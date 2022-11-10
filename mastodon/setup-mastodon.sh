#!/bin/bash

set -euo pipefail

if [ -f ./mastodon.env ] ; then
    echo "Mastodon already initialised, nothing to do."
    exit 0
fi

# Get image versions, admin account
source ./versions.env
source ./admin.env

echo "Starting first-time set-up."

temp_cfg=$(mktemp)
cat ./mastodon.env.template >> "${temp_cfg}"

echo "Generating keys and secrets."

secret="$(docker run -i --network mastodon-net-internal --rm -e RUBYOPT=-W0 \
            ${MASTODON_IMAGE} bundle exec rake secret)"
echo "SECRET_KEY_BASE=${secret}" >> "${temp_cfg}"

secret="$(docker run -i --network mastodon-net-internal --rm -e RUBYOPT=-W0 \
            tootsuite/mastodon:v3.5.3 bundle exec rake secret)"
echo "OTP_SECRET=${secret}" >> "${temp_cfg}"
docker run -i --network mastodon-net-internal --rm -e RUBYOPT=-W0 \
            ${MASTODON_IMAGE} bundle exec rake mastodon:webpush:generate_vapid_key \
    >> "${temp_cfg}"

chmod 444 "${temp_cfg}"

echo "Initialising the database."
docker run -i --network mastodon-net-internal --rm -v "${temp_cfg}":/opt/mastodon/.env.production \
        -e RUBYOPT=-W0 -e DISABLE_DATABASE_ENVIRONMENT_CHECK=1 ${MASTODON_IMAGE} \
        bundle exec rake db:setup

echo "Creating admin user $ADMIN_USER w/ email $ADMIN_EMAIL"

out="$(mktemp)"
# Setting the hostname to the domain of the admin user's email works around a tootctl DNS check issue.
# See https://github.com/mastodon/mastodon/issues/15850 for details.
admin_email_domain="$(echo "${ADMIN_EMAIL}" | sed 's/.*@//')"
docker run -i --network mastodon-net-internal --rm -v "${temp_cfg}":/opt/mastodon/.env.production \
        -e RUBYOPT=-W0 -e RAILS_ENV=production --hostname "${admin_email_domain}" ${MASTODON_IMAGE} \
        bundle exec bin/tootctl accounts create "${ADMIN_USER}" --email "${ADMIN_EMAIL}" --confirmed --role admin \
        >> "${out}"

pass="$(awk '/New password:/ {print $3}' "${out}")"

if [ -z "${pass}" ] ; then
    echo "ERROR: unable to extract password for admin user."
    exit 1
fi

rm "${out}"
echo "ADMIN_PASSWORD='${pass}'" >>admin.env

echo "Precompiling assets."
docker run -i --network mastodon-net-internal --rm -v "${temp_cfg}":/opt/mastodon/.env.production \
        -e RUBYOPT=-W0 -e RAILS_ENV=production ${MASTODON_IMAGE} \
        bundle exec rails assets:precompile

echo "Building initial feed."
docker run -i --network mastodon-net-internal --rm -v "${temp_cfg}":/opt/mastodon/.env.production \
        -e RUBYOPT=-W0 -e RAILS_ENV=production ${MASTODON_IMAGE} \
       bundle exec bin/tootctl feeds build

mv "${temp_cfg}" mastodon.env
chmod 440 mastodon.env
chown mastodon:mastodon mastodon.env

echo "All Done!"                                                                                   

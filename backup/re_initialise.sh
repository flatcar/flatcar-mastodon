#!/bin/bash
#
# (Re-)initialise a system from a backup that has been dumped into the root tree.

chown mastodon:mastodon /opt/mastodon/mastodon.env

source /opt/mastodon/versions.env
chmod 0444 /opt/backup/mastodon_db_backup.sql

# We start the DB container to import the backup SQL dump.
# Note that the container's health check will not succeed until after the dump was imported.
echo "Importing mastodon database"
# We run this in the background instead of using --detach so the log output remains visible
/usr/bin/docker run --rm  \
                  --shm-size=256mb \
                  --health-cmd="pg_isready -U postgres" \
                  --env POSTGRES_HOST_AUTH_METHOD=trust \
                  --volume=/opt/backup/mastodon_db_backup.sql:/docker-entrypoint-initdb.d/mastodon_db.sql \
                  --volume=/opt/mastodon/postgres:/var/lib/postgresql/data \
                  --name=mastodon-db-import \
                  "${POSTGRES_IMAGE}" &

# 20 minutes max for db import. The DB container can be shut down as soon as the DB is up (healthy)
# as the SQL import happens before the DB is started in the container.
/opt/mastodon/wait-for-container.sh mastodon-db-import .State.Health healthy 1200
/usr/bin/docker stop mastodon-db-import

rm /opt/backup/mastodon_db_backup.sql

echo "Enabling mastodon and monitoring service units"
systemctl daemon-reload

# This will be noisy as some of the units come w/o an [Install] section
# (these are pulled in by other units). Warnings are safe to ignore.
for f in /etc/systemd/system/mastodon* \
         /etc/systemd/system/metrics-provider* \
         /etc/systemd/system/monitoring* \
         caddy; do
         u="$(basename "$f")"
         systemctl enable "$u"
done

echo "Starting mastodon, monitoring, and web server"
systemctl start --all "mastodon*" "monitoring-*" "metrics-provider-*" caddy

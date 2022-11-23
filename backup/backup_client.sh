#!/bin/bash                                                                                                                                                 

set -euo pipefail

if [ "${1:-}" = "backup-db" ] ; then
    PGPASSWORD="${DB_PASS}" pg_dump -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}"
    exit
fi

caddy_paths="/opt/caddy"
mastodon_paths="/opt/mastodon/public /opt/mastodon/elasticsearch /opt/mastodon/redis /opt/mastodon/mastodon.env /opt/mastodon/versions.env"
monitoring_paths="/opt/mastodon/grafana/ /opt/mastodon/prometheus/ /opt/mastodon/monitoring-versions.env /opt/mastodon/monitoring-admin.env /opt/mastodon/postgres-monitoring-queries.yaml"
extra_paths="/opt/backup /opt/mastodon/wait-for-container.sh /opt/mastodon/setup-mastodon.sh"

service_wildcards="/etc/systemd/system/mastodon* /etc/systemd/system/monitoring-* /etc/systemd/system/metrics-provider-* /etc/systemd/system/caddy*.service"

source /opt/mastodon/versions.env

echo "CLIENT: Stopping mastodon and monitoring services" >&2
trap 'systemctl start --all "mastodon*" "monitoring*" "metrics*" caddy' EXIT
systemctl stop "mastodon*" "monitoring*" "metrics*" caddy

echo "CLIENT: Creating DB snapshot" >&2
f=$(mktemp)
mv "$f" /opt/backup/mastodon_db_backup.sql

systemctl start mastodon-db
docker run --rm --env-file /opt/mastodon/mastodon.env \
           -v /opt/backup/backup_client.sh:/backup_client.sh \
           --network=mastodon-net-internal ${POSTGRES_IMAGE} \
           /backup_client.sh backup-db >>/opt/backup/mastodon_db_backup.sql
systemctl  stop mastodon-db

echo "CLIENT: Transmitting data" >&2
shopt -s nullglob
tar -pc $caddy_paths $mastodon_paths $monitoring_paths $extra_paths $service_wildcards | docker run --rm -i ghcr.io/flatcar/pigz:latest -c

trap '' EXIT
echo "CLIENT: Starting mastodon and monitoring services" >&2
systemctl start --all "mastodon*" "monitoring*" "metrics*" caddy

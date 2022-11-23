#!/bin/bash

this_script="/opt/backup/restore.sh"

set -euo pipefail

backup_file="${1:-}"

if [ ! -f "${backup_file}" ] ; then
    echo "ERROR: missing backup tarball file."
    echo "Usage: $0 <backup-tarball>"
    echo "                  <backup-tarball> - backup created with 'backup.sh'"
    echo
    exit 1
fi

# Only sith lords and backup files deal in absolutes.
backup_file="$(realpath "${backup_file}")"

if    [[ "${backup_file}" == /opt/mastodon/* ]] \
   || [[ "${backup_file}" == /opt/backup/* ]] \
   || [[ "${backup_file}" == /opt/caddy/* ]] ; then
   echo "ERROR: backup file '${backup_file}' resides in a path that wiĺl be WIPED!"
   echo "       Move outside /opt/mastodon, /opt/backup, or /opt/caddy and try again."
   echo
   exit 1
fi


reinit_script="/opt/backup/re_initialise.sh"

if [ "$(realpath "$0")" = "$this_script" ] ; then
    # The wiping below will also remove this very script, so we create a tempfile to run from.
    tmp_restore_script="$(mktemp)"
    chmod 700 "${tmp_restore_script}"
    cat "${this_script}" >> "${tmp_restore_script}"
    echo "Moving to tempfile '${tmp_restore_script}'"
    exec "${tmp_restore_script}" "${@}"
fi

if [ ! -f "${reinit_script}" ] ; then
    echo "INTERNAL ERROR: re-init script not present."
    exit 2
fi

tmp_reinit_script="$(mktemp)"
chmod 700 "${tmp_reinit_script}"
cat "${reinit_script}" >> "${tmp_reinit_script}"

echo "Stopping and disabling all mastodon, monitoring. and web services, and wiping service files."

systemctl stop "mastodon*" "metrics-provider-*" "monitoring*" "caddy*"

for f in /etc/systemd/system/mastodon* \
         /etc/systemd/system/metrics-provider* \
         /etc/systemd/system/monitoring* \
         caddy; do
         u="$(basename "$f")"
         # Sadly, "disable" does not support globbing like "start" and "stop" do
         systemctl disable "$u"
done

rm -f /etc/systemd/system/mastodon* /etc/systemd/system/metrics-provider-* /etc/systemd/system/monitoring* /etc/systemd/system/caddy*

echo "Removing mastodon, web server, and metrics data."
rm -rf /opt/mastodon/ /opt/caddy/ /opt/backup/ 

echo "Restoring backup from '${backup_file}'" 
cat "${backup_file}"  | docker run --rm -i ghcr.io/flatcar/pigz:latest -d -c - \
                      | tar x --directory /

echo "Re-initialising system"
"${tmp_reinit_script}"

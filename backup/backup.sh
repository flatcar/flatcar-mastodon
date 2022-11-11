#!/bin/bash
#
# Back up an instance and store the data in the local directory.
#
# NOTE that to prevent inconsistent data, the MASTODON SERVICE WILL BE STOPPED for the duration of the backup.
#
# Backup can run either locally or remote. To run locally, start this script without options.
#
# For remote mode, which uses scp/ssh, supply "user@remote_host" and a private key file as first and second argument.

set -euo pipefail
backup_basedir="/opt/backup"

remote=""

if [ "$#" -gt 0 ] ; then
    if [ -n "${1:-}" -a -f "${2:-}" ] ; then
        remote="ssh -i ${2} ${1}"
        echo "Backing up from remote via '${remote}'"
        remote="$remote sudo"
    else
        echo "Error parsing command line arguments."
        echo "Usage: $0 <remote_user@source-host> <private_ssh_key>"
    fi
else
    echo "Backing up from local host"
fi

ts="$(date --rfc-3339=seconds | sed -e 's/[ :]/_/g' -e's/+.*//')"
fname="mastodon-backup-${ts}.tgz"

echo "Pulling backup '${fname}'."
$remote "${backup_basedir}"/backup_client.sh > "${fname}"

echo "Done"

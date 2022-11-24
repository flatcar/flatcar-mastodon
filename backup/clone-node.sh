#!/bin/bash

set -euo pipefail


clone_basedir="/opt/clone"
remote_backup_basedir="/opt/backup"

clone_lockdir="${clone_basedir}/.lock"

if ! mkdir "${clone_lockdir}"; then
    echo "Failed to acquire lock dir '${clone_lockdir}' - did a previous clone attempt fail?"
    exit 1
fi

remote_address="$(cat "$clone_basedir/source_node")"

remote=("ssh"
        "-o" "UserKnownHostsFile=/dev/null"
        "-o" "StrictHostKeyChecking=no"
        "-i" "${clone_basedir}/.ssh/backup_key"
        "${remote_address}"
        "sudo")

echo "Fetching backup."
"${remote[@]}" "${remote_backup_basedir}"/backup_client.sh \
        | docker run --rm -i ghcr.io/flatcar/pigz:latest -d -c - \
        | tar x --directory /

echo "Re-initialising system"
"${clone_basedir}/re_initialise.sh"

rm -rf "${clone_basedir}/.ssh"

echo "Disabling clone-node service"
systemctl disable clone-node.service

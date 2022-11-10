#!/bin/bash
#
# Helper script to wait for a container to enter a certain state.
# Used in systemd services to e.g. ensure containers running or health before continuing.

set -euo pipefail

container="$1"
field="$2"
condition="$3"
timeout="${4:-300}"

echo "Waiting max. ${timeout} seconds for '${container}' field '${field}' to become '${condition}'".

start="$(date +%s)"
until /usr/bin/docker inspect -f "{{${field}}}" "${container}" 2>/dev/null | grep -w "${condition}"; do
    sleep 0.1
    now="$(date +%s)"
    if [ $((now - start)) -gt "$timeout" ] ; then
        echo "Timeout after ${timeout} seconds waiting for '${container}' field '${field}' to become '${condition}'". >&2
        exit 1
    fi
done

<div style="text-align: center">

[![Flatcar OS](https://img.shields.io/badge/Flatcar-Website-blue?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAyNi4wLjMsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjxzdmcgdmVyc2lvbj0iMS4wIiBpZD0ia2F0bWFuXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgODAwIDYwMCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgODAwIDYwMDsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPHN0eWxlIHR5cGU9InRleHQvY3NzIj4NCgkuc3Qwe2ZpbGw6IzA5QkFDODt9DQo8L3N0eWxlPg0KPHBhdGggY2xhc3M9InN0MCIgZD0iTTQ0MCwxODIuOGgtMTUuOXYxNS45SDQ0MFYxODIuOHoiLz4NCjxwYXRoIGNsYXNzPSJzdDAiIGQ9Ik00MDAuNSwzMTcuOWgtMzEuOXYxNS45aDMxLjlWMzE3Ljl6Ii8+DQo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNNTQzLjgsMzE3LjlINTEydjE1LjloMzEuOVYzMTcuOXoiLz4NCjxwYXRoIGNsYXNzPSJzdDAiIGQ9Ik02NTUuMiw0MjAuOXYtOTUuNGgtMTUuOXY5NS40aC0xNS45VjI2MmgtMzEuOVYxMzQuOEgyMDkuNFYyNjJoLTMxLjl2MTU5aC0xNS45di05NS40aC0xNnY5NS40aC0xNS45djMxLjINCgloMzEuOXYxNS44aDQ3Ljh2LTE1LjhoMTUuOXYxNS44SDI3M3YtMTUuOGgyNTQuOHYxNS44aDQ3Ljh2LTE1LjhoMTUuOXYxNS44aDQ3Ljh2LTE1LjhoMzEuOXYtMzEuMkg2NTUuMnogTTQ4Ny44LDE1MWg3OS42djMxLjgNCgloLTIzLjZ2NjMuNkg1MTJ2LTYzLjZoLTI0LjJMNDg3LjgsMTUxTDQ4Ny44LDE1MXogTTIzMywyMTQuNlYxNTFoNjMuN3YyMy41aC0zMS45djE1LjhoMzEuOXYyNC4yaC0zMS45djMxLjhIMjMzVjIxNC42eiBNMzA1LDMxNy45DQoJdjE1LjhoLTQ3Ljh2MzEuOEgzMDV2NDcuN2gtOTUuNVYyODYuMUgzMDVMMzA1LDMxNy45eiBNMzEyLjYsMjQ2LjRWMTUxaDMxLjl2NjMuNmgzMS45djMxLjhMMzEyLjYsMjQ2LjRMMzEyLjYsMjQ2LjRMMzEyLjYsMjQ2LjR6DQoJIE00NDguMywzMTcuOXY5NS40aC00Ny44di00Ny43aC0zMS45djQ3LjdoLTQ3LjhWMzAyaDE1Ljl2LTE1LjhoOTUuNVYzMDJoMTUuOUw0NDguMywzMTcuOXogTTQ0MCwyNDYuNHYtMzEuOGgtMTUuOXYzMS44aC0zMS45DQoJdi03OS41aDE1Ljl2LTE1LjhoNDcuOHYxNS44aDE1Ljl2NzkuNUg0NDB6IE01OTEuNiwzMTcuOXY0Ny43aC0xNS45djE1LjhoMTUuOXYzMS44aC00Ny44di0zMS43SDUyOHYtMTUuOGgtMTUuOXY0Ny43aC00Ny44VjI4Ni4xDQoJaDEyNy4zVjMxNy45eiIvPg0KPC9zdmc+DQo=)](https://www.flatcar.org/)
[![Matrix](https://img.shields.io/badge/Matrix-Chat%20with%20us!-green?logo=matrix)](https://app.element.io/#/room/#flatcar:matrix.org)
[![Slack](https://img.shields.io/badge/Slack-Chat%20with%20us!-4A154B?logo=slack)](https://kubernetes.slack.com/archives/C03GQ8B5XNJ)
[![Twitter Follow](https://img.shields.io/twitter/follow/flatcar?style=social)](https://x.com/flatcar)
[![Mastodon Follow](https://img.shields.io/badge/Mastodon-Follow-6364FF?logo=mastodon)](https://hachyderm.io/@flatcar)
[![Bluesky](https://img.shields.io/badge/Bluesky-Follow-0285FF?logo=bluesky)](https://bsky.app/profile/flatcar.org)

</div>

# flatcar-mastodon
Automation for deploying a Mastodon node on Flatcar.

The files and config snippets in this repository allow to fully auto-provision a Mastodon node on Flatcar Container Linux.
Set-up and configuration is automated via Ignition.
Only instance-specific parameters need to be provided.

## Features
- Fully automated deployment based on very few settings (see HowTo below).
- Automated HTTPS certificate retrieval and installation (via caddy + letsencrypt).
- Includes elasticsearch for full-text indexing.
- Includes comprehensive monitoring suite for web server and mastodon services as well as for the host system and all containers.
- Supports basic back-up and restore, as well as node cloning (e.g. for switching cloud providers, or for horizontal scaling).

## HowTo

**Prerequisites**
1. A domain name for your new Mastodon instance, and access to your domain registrar's DNS (see step 7.).
2. An SMTP account for your instance to send notification emails from (any public freemailer account should work).
3. A cloud service / private cloud / physical server to provision Flatcar on. See 4. below for more information.

**Set-up Instructions**
1. Clone this repo.
2. Configure basic settings for your new instance:
   1. Set the domain name and webmaster email address in [`caddy/Caddyfile`](caddy/Caddyfile).
   2. Configure an initial Mastodon administrator account in [`mastodon/admin.env`](mastodon/admin.env) (user name and email).
      - **DO NOT USE 'admin'** as username. This is a reserved name (Mastodon internal), using 'admin' will cause the initial set-up to fail.
      - It is pretty common in the fediverse to use one's personal account for administration.
        This allows users of your instance to follow their admin, and users of other instances to reach out to you.
        So this can be your personal account if you like.
      - **Note**: The email address you provide here will be used later for the initial login to your instance.
        Make sure there are no typos 😉
   3. Configure an SMTP account for your instance to send notification emails from, and the Mastodon domain (same as web server above) 
      in [`mastodon/mastodon.env.template`](mastodon/mastodon.env.template).
      - Make sure the SMTP configuration is correct as this is the only way of using the initial admin account without manually logging
        into the instance to retrieve the password.
   4. Set up a login (username and password) for your monitoring dashboards at [`monitoring/monitoring-admin.env`](monitoring/monitoring-admin.env).
      You can add more users and change your password later via the Grafana web user interface.
   5. Generate a ssh keypair for remote backups. The keys are also required for node cloning.
      ```shell
      ssh-keygen -P "" -f backup/backup_key
      ```
      Keep your private backup key (generated at `backup/backup_key`) safe!
      It grants (limited) superuser access to the node, and you'll need it for manual and for automated backups, and for cloning your node.
3. Generate Ignition deployment configuration based on your custom settings above by running
   ```shell
   cat mastodon.yaml | docker run --rm -i -v $(pwd):/files quay.io/coreos/butane:latest --files-dir /files > ignition.json
   ```
4. Kick off a [Flatcar installation](https://www.flatcar.org/docs/latest/installing/)
   on [your server](https://www.flatcar.org/docs/latest/installing/bare-metal/),
   on your [favourite public or private cloud](https://www.flatcar.org/docs/latest/installing/cloud/),
   on [your custom virtualisation](https://www.flatcar.org/docs/latest/installing/vms/),
   or on one of the [community contributed platforms](https://www.flatcar.org/docs/latest/installing/community-platforms/).
   Supply the `ignition.json` provisioning config generated above to the deployment (as user data, custom data etc. - it's provider specific).
5. As soon as the provisioning started and you know the final IP address of your instance, update your domain in your registrar's DNS to point to the IP of the new instance.
   This will allow caddy to retrieve a letsencrypt HTTPS certificate during provisioning.
6. Wait for the deployment to conclude.
   You should receive a welcome email from your new Mastodon instance in the administrator account's inbox (see step #3 above).
   The email should arrive at about the time everything is set up, so you can access your instance right away!
   Log in with the admin account's email address and use Mastodon's "reset password" feature to set a new password.
   Alternatively, ssh into the instance and check `/opt/mastodon/admin.env` for the password auto-generated by Mastodon during provisioning.

Your instance will be available directly via `https://${DOMAIN}/`.
You can access your monitoring dashboards at `https://${DOMAIN}/monitoring/` using the account you defined in step 2.4. above.

## Monitoring

The deployment ships with a comprehensive monitoring suite.
Prometheus is used to scrape and to store telemetry.
Grafana dashboards are provided to keep track of various system components.

Grafana dashboards are available at `https://${DOMAIN}/monitoring/` using the monitoring login defined in [`monitoring/monitoring-admin.env`](monitoring/monitoring-admin.env).

We include the following dashboards:
- Caddy web server requests / responses, latency, etc.
- node-exporter host telemetry - CPU and memory load, disk space, etc.
- cadvisor container telemetry - active containers, resource usage per container, etc.
- Mastodon - posts, users, known instances.
- Mastodon Sidekiq - workers, queues, jobs processed, job errors etc.
- Redis - resource usage, command processing / time spent, client connections, etc.
- elasticsearch - CPU / Memory usage, index/query/queue stats, thread pool state, shards state, etc.
- postgres - resource usage, connections/transactions/buffer state, locks, I/O latency etc.
- Resource usage of the monitoring system (container / host stats filtered to only include monitoring containers).

## Maintenance

The `mastodon-setup` start-up phase (step 2 above) is also useful for maintenance and debugging.
At this stage, only low-level components are up - allowing to start a maintenance environment like e.g.
```shell
systemctl stop mastodon
systemctl start mastodon-setup
source /opt/mastodon/versions.env
docker run -it --rm --network=mastodon-net-internal --env-file="./mastodon.env" -e RAILS_ENV=production ${MASTODON_IMAGE} bash
```
and interacting with the mastodon installation via `bin/tootctl`.

### Update container image versions

Edit `/opt/mastodon/versions.env` and update the version tags.
For minor / patch updates that do not require database migration, simply run `systemctl restart mastodon`.
If DB migration and/or other manual upgrade steps are needed, enter maintenance mode (see above) and perform the required steps.

Common migration steps include .e.g
```
bundle exec rake mastodon:setup           # migrate the database
bundle exec rails assets:precompile       # recompile web assets
bundle exec bin/tootctl feeds build       # re-generate feeds
bundle exec bin/tootctl search deploy     # re-generate full-text search index
```

## Backup and restore, node cloning and vertical scaling

Automation ships with basic backup and restore features. 
Both node-local and remote backups are supported.

Also, a "clone node" provisioning automation is supplied which will create a new Mastodon deployment based on an existing one.
Node cloning can be used to switch providers, move to or from on-prem deployments, and for vertically scaling (increase or decrease instance size).

**NOTE** Mastodon and monitoring services will be shut down temporarily during the backup to prevent inconsistencies.

The following is backed up:
- Mastodon configuration, user data (uploads etc.), redis and elasticsearch state.
- Monitoring configuration and all past telemetry.
- Web server logs, configuration, and state (e.g. https certificates).
- Backup scripts in `/opt/backup` to preserve local changes.
- All relevant systemd units.
  This will preserve customised parameters in these units.
  Also, wildcard matches are used for backup, so any additional custom `metrics-provider-*`, `monitoring-*`, `mastodon*`, and `caddy*` files are included in the backup.

A `backup` account is provided for both local and remote backups.
The account has `sudo` access to the `backup_client.sh` script in `/opt/backup/` but is otherwise restricted.

### Clone a node

**Prerequisites**: backup user private key file, user+host of the source node.

1. Edit [`clone-node.yaml`](clone-node.yaml) and replace `BACKUPUSER@HOST` with user name (likely `backup`) and source host (IP or domain name).
2. Supply backup private key file at `backup/backup_key`
3. Generate Ignition deployment configuration based on these settings by running
   ```shell
   cat clone-node.yaml | docker run --rm -i -v $(pwd):/files quay.io/coreos/butane:latest --files-dir /files > clone.json
   ```
4. Provision a new Flatcar node with your favourite hoster (or on prem, or private cloud) and supply `clone.json` as user data / custom data.
   Note that the new node needs to be able to reach the source node via SSH.
5. Wait for the deployment to conclude.
   Update DNS entries of your domain to point to the new node's IP address.

### Node-local backup

Ssh into the node, change to the directory you want the backup to be created in, and run
```shell
sudo /opt/backup/backup.sh
```
You can also set up a systemd timer unit to make regular backups.
The backup tarball will be created in the local directory `/opt/backup/backup.sh` was called from.
The tarball will follow the pattern `mastodon-backup-YYYY-MM-DD_hh_mm_ss.tgz`.
Backup tarballs include all files required for restore with their full paths in the filesystem root.

**NOTE** Mastodon and monitoring services will be shut down temporarily during the backup to prevent inconsistencies.

**NOTE** Do not put your backup files to `/opt/backup`; that directory is only for backup scripts and will be WIPED during a restore.

### Remote backup

Remote backups use ssh and are authenticated via public ssh keys in `/home/backup/.ssh/authorized_keys`.
By default, this includes the public key of the SSH backup key pair generated in the HowTo (see HowTo step 2.5. above).
Backup is performed via the [`backup/backup.sh`](backup/backup) script in this repository, passing both the remote user+host and the private key as a parameter, e.g.:
```
backup/backup.sh backup@mydomain.social backup/backup_key
```

**NOTE** Mastodon and monitoring services will be shut down temporarily during the backup to prevent inconsistencies.

### Restore

Node restore works on a backup created with `backup.sh` (see above).
Restore will first stop all running Mastodon / monitoring services and wipe all related files and service units.
Then, it will restore all files from the backup tarball to root, install systemd services, and initialise the database.
Lastly, it will start all mastodon / monitoring services.

**NOTE** Mastodon and monitoring services will be shut down before restore, and all files will be wiped from `/opt/mastodon`, `/opt/caddy`, and `/opt/backup`.

## List of Containers and Connectivity to Container Networking

The deployment uses 2 user-defined container networks - an "external" network through which containers can reach the internet, and an "internal" one without any internet connectivity.
Only ports exposed on the "external" net are internet accessible.
Furthermore, 2 containers use host mode networking.

* Container on "external" network with ports exposed to the internet
  * Caddy
* Host network mode containers with ports exposed on localhost
  * CAdvisor
  * Node-exporter
* Container on "external" network with ports exposed to localhost
  * Mastodon web
  * Mastodon streaming
  * Grafana
* Container on "external" network without ports exposed
  * Mastodon Sidekiq
  * Prometheus
  * Mastodon Prometheus exporter
* Containers only on the "internal" network without internet access
  * Redis
  * Postgres
  * Elasticsearch
  * Redis Prometheus exporter
  * Postgres Prometheus exporter
  * Elasticsearch Prometheus exporter
  * Mastodon Sidekiq Prometheus exporter

## Services Dtructure and Dependencies

All services start automatically at boot.

All mastodon services are grouped in an umbrella service and can be started with `systemctl start mastodon` and torn down with `systemctl stop mastodon` respectively.

Services dependent on other services are displayed towards the root; services w/o dependencies are leaves.

```
mastodon.service                              - Umbrella service that depends on all services.
│                                               All dependent services will also be torn down when "mastodon.service" is stopped.
├── mastodon-sidekiq.service                  - Background processing, uses internal + external networking and DBs.
│   ├── mastodon-net-external.service         - Docker user-defined network for external networking.
│   └── mastodon-setup.service                - First-time setup. NOP after installation; useful for maintenance.
│       │                                       Runs with internal network only, needs all DBs.
│       ├── mastodon-db.service               - Postgres, reachable via internal network only.
│       ├── mastodon-es.service               - Elasticsearch, reachable via internal network only.
│       └── mastodon-redis.service            - Redis, reachable via internal network only.
│           └── mastodon-net-internal.service - User-defined container network for internal networking. No I/O to the outside.
├── mastodon-streaming.service                - Streaming API, uses internal + external networking and DBs, listens to 127.0.0.1:5051.
│   ├── mastodon-net-external.service
│   └── mastodon-setup.service
│       ├── mastodon-db.service
│       ├── mastodon-es.service
│       └── mastodon-redis.service
│           └── mastodon-net-internal.service
└── mastodon-web.service                      - Website, uses internal + external networking and DBs, listens to 127.0.0.1:5050.
    ├── mastodon-net-external.service
    └── mastodon-setup.service
        ├── mastodon-db.service
        ├── mastodon-es.service
        └── mastodon-redis.service
            └── mastodon-net-internal.service

caddy.service                                 - Web server proxy and HTTPS termination. Takes care of certs, too.
│                                               Proxies on external network to mastodon-web (127.0.0.1:5050)
│                                                and mastodon-streaming (127.0.0.1:5051).
└── mastodon-net-external.service             - Docker user-defined network for external networking.
```

### Start-up procedure

1. External and internal container networks are started first.
2. Databases (postgres, redis, and elasticsearch) are started as soon as the internal network is up.
3. The initial set-up script runs.
   This is a NOP for subsequent starts after installation.
   However, this stage is also useful for maintenance (see below).
4. Higher level services are starting: web, sidekiq, and streaming.


#!/bin/sh
export LC_ALL=C TERM="xterm"

#adding testing repository 
echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk --no-cache upgrade

## Install init process.
cp /build/bin/my_init /sbin/
chmod 750 /sbin/my_init
mkdir -p /etc/my_init.d
mkdir -p /etc/container_environment
touch /etc/container_environment.sh
touch /etc/container_environment.json
chmod 700 /etc/container_environment

addgroup -g 8377 docker_env
chown :docker_env /etc/container_environment.sh /etc/container_environment.json
chmod 640 /etc/container_environment.sh /etc/container_environment.json
ln -s /etc/container_environment.sh /etc/profile.d/

## Install runit.
apk --no-cache add runit

## Install cron daemon.
mkdir -p /etc/service/cron
mkdir -p /etc/service/cron/log
mkdir -p /var/log/cron
chmod 600 /etc/crontabs
cp /build/runit/cron /etc/service/cron/run
cp /build/runit/cron_log /etc/service/cron/log/run
cp /build/config/cron_log_config /var/log/cron/config
chmod +x /etc/service/cron/run /etc/service/cron/log/run

## Remove useless cron entries.
# Checks for lost+found and scans for mtab.
rm -f /etc/cron.daily/standard
rm -f /etc/cron.daily/password
rm -f /etc/cron.weekly/fstrim

## Often used tools.
apk --no-cache add psmisc

#cleanup
rm -rf /build
rm -rf /tmp/* /var/tmp/*

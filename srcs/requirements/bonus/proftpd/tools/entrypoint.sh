#!/bin/sh

echo www-data:$(cat /run/secrets/proftpd_password) | chpasswd

exec $@

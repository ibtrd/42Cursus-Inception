#!/bin/sh
set -e

export MYSQL_DATABASE=$(cat /run/secrets/mysql_database)
export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mysql_root_password)
export MYSQL_USER=$(cat /run/secrets/mysql_user)
export MYSQL_PASSWORD=$(cat /run/secrets/mysql_password)
envsubst < /run/initdb.sql | sponge /run/initdb.sql
exec $@ --init-file=/run/initdb.sql

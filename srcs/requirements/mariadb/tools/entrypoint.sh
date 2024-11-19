#!/bin/sh

set -e

# until mysqladmin ping -h"mariadb:9000" --silent; do
#     sleep 1
# done

if [ ! -d "/var/lib/mysql/mysql" ]; then
	export MYSQL_DATABASE=$(cat /run/secrets/mysql_database)
	export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mysql_root_password)
	export MYSQL_PASSWORD=$(cat /run/secrets/mysql_password)
	export MYSQL_USER=$(cat /run/secrets/mysql_user)
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

exec mysqld

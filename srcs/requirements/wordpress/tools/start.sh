#!/bin/sh

# set -e

wp core is-installed
if [ ! $? -eq 0 ]; then
	wp core download
	# wp config create --dbhost=mariadb:3306 --dbname=wordpress --dbuser=wordpress	\

# 	wp core install \
#         --url="https://www.ibertran.42.fr" \
#         --title="Inception" \
#         --admin_user="wordpress" \
#         --admin_password="wordpress" \
#         --admin_email="admin@example.com" \
#         --allow-root
fi

php-fpm82 -F

#!/bin/sh

ENTRY_ARGS="$@"

until nc -z -v mariadb 3306; do
	sleep 1
done

if ! wp core is-installed ; then
	# DOWNLOAD WORDPRESS
	wp core download

	# INIT WP-CONFIG.PHP
	wp config create \
		--dbhost=mariadb:3306 \
		--dbname=$(cat /run/secrets/mysql_database) \
		--dbuser=$(cat /run/secrets/mysql_user) \
		--dbpass=$(cat /run/secrets/mysql_password)

	# CREATE ADMINISTRATOR
	set -- $(head -1 /run/secrets/wp_credentials)
	wp core install \
		--url=$DOMAIN \
		--title=Inception \
		--admin_user=$1 \
		--admin_email=$2 --skip-email \
		--admin_password=$3

	# CREATE ADDITIONNAL USERS
	ADMIN=true
	while read LINE
	do
		if [ "$ADMIN" = true ]; then
			ADMIN=false
			continue
		fi

		set -- $LINE
		wp user create $1 $2 --user_pass=$3
	done < /run/secrets/wp_credentials
	
	# SETUP REDIS CACHE
	wp config set WP_REDIS_HOST 'redis' \
		&& wp config set WP_REDIS_PORT 6379 --raw \
		&& wp config set WP_REDIS_MAXTTL 3600 --raw \
		&& wp config set WP_REDIS_TIMEOUT 1.5 --raw \
		&& wp config set WP_REDIS_READ_TIMEOUT 1.5 --raw \
		&& wp plugin install redis-cache --activate \
		&& wp redis enable

	# SET THEME
	if ! wp theme is-installed $WP_THEME; then
		echo install
		wp theme install $WP_THEME
	fi
	if wp theme is-installed $WP_THEME && ! wp theme is-active $WP_THEME; then
		echo active
		wp theme activate $WP_THEME
	fi
fi

chown -R www-data:www-data /website

# LAUNCH PHP-FPM
exec $ENTRY_ARGS

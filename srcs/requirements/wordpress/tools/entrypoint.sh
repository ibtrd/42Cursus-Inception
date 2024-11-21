#!/bin/sh

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
	wp core install \
		--url=$DOMAIN \
		--title=Inception \
		--admin_user=$(cat /run/secrets/wp_admin) \
		--admin_email=$(cat /run/secrets/wp_admin_email) \
		--admin_password=$(cat /run/secrets/wp_admin_password)

	# CREATE ADDITIONNAL USER
	wp user create \
		$(cat /run/secrets/wp_user) \
		$(cat /run/secrets/wp_user_email) \
		--user_pass=$(cat /run/secrets/wp_user_password)
	
	# SETUP REDIS CACHE
	wp config set WP_REDIS_DISABLED false --raw
	wp config set WP_REDIS_HOST 'redis'
	wp config set WP_REDIS_PORT 6379 --raw
	wp config set WP_REDIS_MAXTTL 3600 --raw
	wp config set WP_REDIS_TIMEOUT 1.5 --raw
	wp config set WP_REDIS_READ_TIMEOUT 1.5 --raw
	wp plugin install redis-cache --activate
	# wp redis enable

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
exec $@

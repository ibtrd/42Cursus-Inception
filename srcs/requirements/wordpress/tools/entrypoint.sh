#!/bin/sh

until nc -z -v mariadb 3306; do
	sleep 1
done


if ! wp core is-installed ; then
	wp core download
	wp config create \
		--dbhost=mariadb:3306 \
		--dbname=$(cat /run/secrets/mysql_database) \
		--dbuser=$(cat /run/secrets/mysql_user) \
		--dbpass=$(cat /run/secrets/mysql_password)
	wp core install \
		--url=$DOMAIN \
		--title=Inception \
		--admin_user=$(cat /run/secrets/wp_admin) \
		--admin_email=$(cat /run/secrets/wp_admin_email) \
		--admin_password=$(cat /run/secrets/wp_admin_password)
	wp user create \
		$(cat /run/secrets/wp_user) \
		$(cat /run/secrets/wp_user_email) \
		--user_pass=$(cat /run/secrets/wp_user_password)
fi

if ! wp theme is-installed $WP_THEME; then
	echo install
    wp theme install $WP_THEME
fi

if wp theme is-installed $WP_THEME && ! wp theme is-active $WP_THEME; then
	echo active
    wp theme activate $WP_THEME
fi

exec $@

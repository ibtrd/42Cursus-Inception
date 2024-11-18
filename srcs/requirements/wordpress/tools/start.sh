#!/bin/sh

if [ ! -d $PWD/wordpress ]; then
	curl -O https://wordpress.org/latest.tar.gz && \
		tar -xvzf latest.tar.gz && \
		rm -rf latest.tar.gz
fi
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

php-fpm82 -F

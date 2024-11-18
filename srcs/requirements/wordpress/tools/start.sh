#!/bin/sh

if [ ! -d $PWD/wordpress ]; then
	curl -O https://wordpress.org/latest.tar.gz && \
		tar -xvzf latest.tar.gz && \
		rm -rf latest.tar.gz
fi

php-fpm82 -F

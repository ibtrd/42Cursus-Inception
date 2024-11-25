# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/02 04:48:07 by ibertran          #+#    #+#              #
#    Updated: 2024/11/25 15:31:47 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache \
redis \
php82-tokenizer \
php82-redis \
php82-phar \
php82-mysqli \
php82-mbstring \
php82-fpm \
php82-curl \
php82-ctype

ARG WP_CLI_URL

RUN wget ${WP_CLI_URL} \
	&& chmod +x $(basename ${WP_CLI_URL}) \
	&& mv $(basename ${WP_CLI_URL}) /usr/local/bin/wp

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /website

RUN adduser -D -S -G www-data -u 82 www-data

EXPOSE 9000

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "php-fpm82", "-F" ]

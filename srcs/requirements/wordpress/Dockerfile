# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/02 04:48:07 by ibertran          #+#    #+#              #
#    Updated: 2024/11/03 05:34:10 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache php82-fpm \
	curl

WORKDIR /var/www/

RUN curl -O https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && \
	rm -rf latest.tar.gz

COPY  www.conf /etc/php82/php-fpm.d/www.conf

EXPOSE 9000

CMD ["php-fpm82", "-F"]

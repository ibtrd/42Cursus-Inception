# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/02 04:48:07 by ibertran          #+#    #+#              #
#    Updated: 2024/11/09 21:00:25 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache mariadb envsubst moreutils

RUN mkdir -p /var/lib/mysql /run/mysqld \
	&& chown mysql:mysql /var/lib/mysql /run/mysqld
	
COPY tools/initdb.sql /run/initdb.sql
RUN chown mysql:mysql /run/initdb.sql
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "mariadbd", "--user=mysql" ]

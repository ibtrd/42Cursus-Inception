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

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld
	
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/initdb.sql /docker-entrypoint-initdb.d/
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

USER mysql

ENTRYPOINT [ "entrypoint.sh" ]
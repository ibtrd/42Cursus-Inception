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

# RUN --mount=type=secret,id=mysql_root_password,env=MYSQL_ROOT_PASSWORD \
#     --mount=type=secret,id=mysql_database,env=MYSQL_DATABASE \
# 	--mount=type=secret,id=mysql_user,env=MYSQL_USER \
# 	--mount=type=secret,id=mysql_password,env=MYSQL_PASSWORD

	RUN --mount=type=secret,id=mysql_root_password \
    sh -c 'export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mysql_root_password)'

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld

USER mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/initdb.sql /docker-entrypoint-initdb.d/

# RUN mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

EXPOSE 3306

CMD [ "mysqld", "--init-file=/docker-entrypoint-initdb.d/initdb.sql" ]
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/22 13:07:50 by ibertran          #+#    #+#              #
#    Updated: 2024/11/24 20:46:03 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

ARG CADVISOR_DOWNLOAD_URL

RUN wget -O /usr/local/bin/cadvisor $CADVISOR_DOWNLOAD_URL \
	&& chmod +x /usr/local/bin/cadvisor

EXPOSE 8080

ENTRYPOINT [ "cadvisor" ]
# ENTRYPOINT [ "cadvisor", "--http_auth_file /run/secrets/htpasswd", "--http_auth_realm localhost", "--docker_only" ]

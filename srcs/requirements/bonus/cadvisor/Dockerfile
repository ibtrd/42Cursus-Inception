# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/22 13:07:50 by ibertran          #+#    #+#              #
#    Updated: 2024/11/25 12:00:44 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

ARG CADVISOR_DOWNLOAD_URL

RUN wget -O /usr/local/bin/cadvisor $CADVISOR_DOWNLOAD_URL \
	&& chmod +x /usr/local/bin/cadvisor

EXPOSE 8080

ENTRYPOINT [ "cadvisor" ]

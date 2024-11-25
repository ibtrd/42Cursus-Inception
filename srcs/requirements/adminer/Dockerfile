# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/20 21:51:14 by ibertran          #+#    #+#              #
#    Updated: 2024/11/24 18:57:17 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache \
	php82 \
	php82-mysqli \
	php82-session

WORKDIR /app

ARG ADMINER_DOWNLOAD_URL

RUN wget ${ADMINER_DOWNLOAD_URL}

RUN mv $(basename $ADMINER_DOWNLOAD_URL) index.php

EXPOSE 8000

ENTRYPOINT [ "php" , "-S", "0.0.0.0:8000" ]

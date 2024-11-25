# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/02 04:48:07 by ibertran          #+#    #+#              #
#    Updated: 2024/11/24 19:56:19 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/ibertran.conf /etc/nginx/http.d/ibertran.conf
COPY conf/calculator.conf /etc/nginx/http.d/calculator.conf
COPY conf/adminer.conf /etc/nginx/http.d/adminer.conf
COPY conf/cadvisor.conf /etc/nginx/http.d/cadvisor.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

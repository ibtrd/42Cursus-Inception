# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/02 04:48:07 by ibertran          #+#    #+#              #
#    Updated: 2024/11/22 19:04:36 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/ibertran.conf /etc/nginx/http.d/ibertran.conf
COPY conf/calculator.conf /etc/nginx/http.d/calculator.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

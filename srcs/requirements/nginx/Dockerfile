# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/02 04:48:07 by ibertran          #+#    #+#              #
#    Updated: 2024/11/03 05:34:28 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk update && \
	apk upgrade && \
	apk add nginx

COPY nginx.conf /etc/nginx/nginx.conf

COPY *.html /usr/share/nginx/

COPY www.ibertran.42.fr.crt /etc/ssl/certs/
COPY www.ibertran.42.fr.key /etc/ssl/private/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
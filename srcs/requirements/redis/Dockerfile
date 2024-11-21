# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/20 17:39:50 by ibertran          #+#    #+#              #
#    Updated: 2024/11/20 20:17:10 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache redis

# COPY conf/redis.conf /etc/redis.conf

EXPOSE 6379

ENTRYPOINT [ "redis-server" ]
CMD [ "--protected-mode no" ]
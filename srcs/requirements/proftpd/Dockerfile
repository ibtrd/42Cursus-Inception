# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/21 17:16:39 by ibertran          #+#    #+#              #
#    Updated: 2024/11/21 22:12:48 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache proftpd

COPY conf/proftpd.conf /etc/proftpd/

COPY tools/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

RUN adduser -S -G www-data -u 82 www-data
RUN mkdir /run/proftpd && chown -R proftpd:proftpd /run/proftpd

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "proftpd", "-c", "/etc/proftpd/proftpd.conf", "-n" ]

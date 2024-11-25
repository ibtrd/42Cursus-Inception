# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/22 13:07:50 by ibertran          #+#    #+#              #
#    Updated: 2024/11/22 19:20:18 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19 AS builder

RUN apk add --no-cache npm

COPY calculator .

RUN npm install && npm run build

# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache npm

COPY --from=builder build app

RUN npm install -g serve

WORKDIR /app

EXPOSE 3000

ENTRYPOINT [ "serve" ]

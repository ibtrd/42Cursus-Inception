# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/02 04:49:05 by ibertran          #+#    #+#              #
#    Updated: 2024/11/03 06:33:15 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

NAME := inception

COMPOSE_FILE := ./srcs/docker-compose.yml

up: down
	docker compose -p $(NAME) -f $(COMPOSE_FILE) up --build

PHONY: down
down:
	docker compose -f $(COMPOSE_FILE) down

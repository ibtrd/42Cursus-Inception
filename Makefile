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
WEBSITE := ibertran.42.fr

COMPOSE_FILE := ./srcs/docker-compose.yml

SECRETS_DIR := secrets/
SSL_CERT := $(SECRETS_DIR)ibertran.42.fr.crt \


.PHONY: detach
detach: $(SSL_CERT)
	docker compose -p $(NAME) -f $(COMPOSE_FILE) up --build -d

.PHONY: up
up: $(SSL_CERT)
	docker compose -p $(NAME) -f $(COMPOSE_FILE) up --build

.PHONY: down
down:
	docker compose -p $(NAME) -f $(COMPOSE_FILE) down

$(SSL_CERT): | $(SECRETS_DIR)
	openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 \
	-nodes -keyout $(SECRETS_DIR)$(WEBSITE).key -out $(SECRETS_DIR)$(WEBSITE).crt -subj "/CN=$(WEBSITE)" \
	-addext "subjectAltName=DNS:$(WEBSITE),DNS:*.$(WEBSITE),IP:10.0.0.1"

$(SECRETS_DIR) :
	mkdir $@

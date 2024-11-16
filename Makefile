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

SECRETS_DIR := secrets/
SSL_CERT := $(SECRETS_DIR)$(WEBSITE).crt
SSL_KEY := $(SECRETS_DIR)$(WEBSITE).key

COMPOSE_FILE := ./srcs/docker-compose.yml

DIRS := $(SECRETS_DIR) $(HOME)/data/wp-website $(HOME)/data/wp-database

.PHONY: detach
detach: $(SSL_CERT) $(SSL_KEY) | $(DIRS)
	docker compose -p $(NAME) -f $(COMPOSE_FILE) up --build -d

.PHONY: up
up: $(SSL_CERT) $(SSL_KEY) | $(DIRS)
	docker compose -p $(NAME) -f $(COMPOSE_FILE) up --build

.PHONY: down
down:
	docker compose -p $(NAME) -f $(COMPOSE_FILE) down

.PHONY: build | $(DIRS)
build: $(SSL_CERT) $(SSL_KEY)
	docker compose -p $(NAME) -f $(COMPOSE_FILE) build

.PHONY: ssl
ssl: $(SSL_CERT) $(SSL_KEY)

$(SSL_CERT) $(SSL_KEY): | $(SECRETS_DIR)
	openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 \
	-nodes -keyout $(SSL_KEY) -out $(SSL_CERT) -subj "/CN=$(WEBSITE)" \
	-addext "subjectAltName=DNS:$(WEBSITE),DNS:*.$(WEBSITE),IP:10.0.0.1" 2> /dev/null

$(DIRS) :
	mkdir -p $@

.PHONY: fclean
fclean :
	docker compose -p $(NAME) -f $(COMPOSE_FILE) rm -vsf
	$(RM) -r $(HOME)/data/wp-website $(HOME)/data/wp-database


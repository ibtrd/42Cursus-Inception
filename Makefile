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
COMPOSE_CMD := docker compose -p $(NAME) -f $(COMPOSE_FILE)

VOL_DIR := $(HOME)/data/
VOL_NAMES := \
	wp-website \
	wp-database
VOLUMES := $(addprefix $(VOL_DIR), $(VOL_NAMES))

# **************************************************************************** #

.PHONY: detach
detach: $(SSL_CERT) $(SSL_KEY) | $(VOLUMES)
	$(COMPOSE_CMD) up -d --build

.PHONY: up
up: $(SSL_CERT) $(SSL_KEY) | $(VOLUMES)
	$(COMPOSE_CMD) up

.PHONY: down
down:
	$(COMPOSE_CMD) down

.PHONY: build
build: $(SSL_CERT) $(SSL_KEY)
	$(COMPOSE_CMD) build

$(VOLUMES) $(SECRETS_DIR):
	mkdir -p $@

.PHONY: fclean
fclean:
	$(COMPOSE_CMD) rm -vsf
	for VOL in $(VOL_NAMES); do docker volume rm $(NAME)_$$VOL; done

# **************************************************************************** #

.PHONY: ssl
ssl: $(SSL_CERT) $(SSL_KEY)

$(SSL_CERT) $(SSL_KEY): | $(SECRETS_DIR)
	openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 \
	-nodes -keyout $(SSL_KEY) -out $(SSL_CERT) -subj "/CN=$(WEBSITE)" \
	-addext "subjectAltName=DNS:$(WEBSITE),DNS:*.$(WEBSITE),IP:10.0.0.1" 2> /dev/null

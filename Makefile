# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ibertran <ibertran@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/02 04:49:05 by ibertran          #+#    #+#              #
#    Updated: 2024/11/22 12:22:06 by ibertran         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

NAME := inception
WEBSITE := ibertran.42.fr

SECRETS_DIR := secrets/ssl/
SSL_CERT := $(SECRETS_DIR)$(WEBSITE).crt
SSL_KEY := $(SECRETS_DIR)$(WEBSITE).key

COMPOSE_FILE := ./srcs/docker-compose.yml
COMPOSE_CMD := docker compose -p $(NAME) -f $(COMPOSE_FILE)

VOL_DIR := $(HOME)/data/
VOL_NAMES := \
	website \
	database
VOLUMES := $(addprefix $(VOL_DIR), $(VOL_NAMES))


# **************************************************************************** #

.PHONY: detach
detach: $(SSL_CERT) $(SSL_KEY) | $(VOLUMES)
	$(COMPOSE_CMD) up -d

.PHONY: up
up: $(SSL_CERT) $(SSL_KEY) | $(VOLUMES)
	$(COMPOSE_CMD) up

.PHONY: down
down: $(SSL_CERT) $(SSL_KEY) | $(VOLUMES)
	$(COMPOSE_CMD) down

.PHONY: restart
restart:
	$(COMPOSE_CMD) restart

.PHONY: build
build: $(SSL_CERT) $(SSL_KEY)
	$(COMPOSE_CMD) build

$(VOLUMES) $(SECRETS_DIR):
	mkdir -p $@

.PHONY: exec-%
exec-%:
	docker exec -it $(shell echo $(patsubst exec-%,%,$@) | sed 's/-/ /g')

.PHONY: sh-%
sh-%:
	docker exec -it $(patsubst sh-%,%,$@) sh

.PHONY: fclean
fclean: down
	-$(COMPOSE_CMD) rm
	-for VOL in $(VOL_NAMES); do docker volume rm $(NAME)_$$VOL; done
	-sudo rm -rf $$HOME/data

.PHONY: re
re: fclean
	$(MAKE) build
	$(MAKE)

# **************************************************************************** #

.PHONY: ssl
ssl: $(SSL_CERT) $(SSL_KEY)

$(SSL_CERT) $(SSL_KEY): | $(SECRETS_DIR)
	openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 \
	-nodes -keyout $(SSL_KEY) -out $(SSL_CERT) -subj "/CN=$(WEBSITE)" \
	-addext "subjectAltName=DNS:$(WEBSITE),DNS:*.$(WEBSITE),IP:10.0.0.1" 2> /dev/null

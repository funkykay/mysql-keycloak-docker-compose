THIS_FILE := $(lastword $(MAKEFILE_LIST))
.PHONY: help build up start down destroy stop restart logs logs-api ps login-timescale login-api db-shell

help:
	make -pRrq  -f $(THIS_FILE) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
build:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env build $(c)
up:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env up -d $(c)
start:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env start $(c)
down:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env down $(c)
destroy:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env down -v $(c)
stop:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env stop $(c)
restart:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env stop $(c)
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env up -d $(c)
logs:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env logs --tail=100 -f $(c)
ps:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env ps
db-shell:
	docker-compose -f ./docker/docker-compose.yaml --env-file ./.env exec mysql

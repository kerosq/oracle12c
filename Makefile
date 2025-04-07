#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo ----------------------
	@echo start / stop / restart
	@echo ----------------------
	@echo ps / logs / stats
	@echo clean
	@echo ----------------------

_header:
	${info }
	@echo ----------------
	@echo Oracle en Docker
	@echo ----------------

start:
	@docker compose up -d --remove-orphans

stop:
	@docker compose stop

restart: stop start

ps:
	@docker ps

logs:
	@docker compose logs server

stats:
	@docker stats

clean:
	@docker compose down -v --remove-orphans

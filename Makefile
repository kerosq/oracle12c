#!make

THIS_FILE := $(lastword $(MAKEFILE_LIST))

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

_colima-start:
	@colima start --profile colima-oracle --arch x86_64 --memory 4

_colima-stop:
	@colima stop --profile colima-oracle

_colima-delete:
	@colima delete --profile colima-oracle -f

_context-colima:
	@docker context use colima-oracle

_context-docker-desktop:
	@docker context use default

_start_command:
	@docker compose up -d --remove-orphans

start:
	@$(MAKE) -f $(THIS_FILE) _start_command

_stop_command:
	@docker compose stop

stop:
	@$(MAKE) -f $(THIS_FILE) _stop_command

restart: stop start

_ps_command:
	@docker ps

ps:
	@$(MAKE) -f $(THIS_FILE) _ps_command

_logs_command:
	@docker compose logs server

logs:
	@$(MAKE) -f $(THIS_FILE) _logs_command

_stats_command:
	@docker stats

stats:
	@$(MAKE) -f $(THIS_FILE) _stats_command

_clean_command:
	@docker compose down -v --remove-orphans

clean:
	@$(MAKE) -f $(THIS_FILE) _clean_command

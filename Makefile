build:
	sudo docker build -t="docker-sentry-postgres" .

run:
	@sudo docker run -d docker-sentry-postgres
	@echo "Ports mapping:"
	@sudo docker ps | grep "docker-sentry-postgres" | grep -o -P "\d*->\d*"

ssh:
	@ssh -p $(sudo docker ps | grep "docker-sentry-postgres" | grep -o -P "\d*->22" | grep -o -P "^\d*") root@127.0.0.1

show-running:
	@sudo docker ps | grep "docker-sentry-postgres"

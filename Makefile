build:
	sudo docker build -t="docker-sentry-postgres" .

run:
	@sudo docker run -d docker-sentry-postgres
	@echo "Ports mapping:"
	@sudo docker ps | grep "docker-sentry-postgres" | grep -o -P "\d*->\d*"

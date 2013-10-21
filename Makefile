build:
	sudo docker build -t="docker-sentry-postgres" .

run:
	@sudo docker run -d kev/docker-uptime
	@echo "Ports mapping:"
	@sudo docker ps | grep "docker-sentry-postgres" | grep -o -P "\d*->\d*"

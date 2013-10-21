# Dockerfile for sentry (with postgres)
# https://github.com/fzaninotto/uptime
#
# VERSION 0.1.0

FROM ubuntu
MAINTAINER Eugene Kalinin <e.v.kalinin@gmail.com>

# refresh soft
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# locales (for postgres)
RUN apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8
#RUN dpkg-reconfigure locales

# editor
RUN apt-get install -y vim

# install postgres
RUN apt-get install -y postgresql postgresql-contrib libpq-dev

# python related soft (including pip)
RUN apt-get install -y build-essential python-dev python-virtualenv

# supervisord
RUN mkdir -p /var/log/supervisor
RUN apt-get install -y supervisor

# ssh
RUN mkdir -p /var/run/sshd
RUN apt-get install -y openssh-server
RUN /bin/sh -c 'echo root:sentry | chpasswd'

# sentry & pg driver
RUN pip install psycopg2
RUN pip install sentry

# config for sentry
ADD conf/sentry.conf.py /sentry.conf.py

# config for auto start ssh/mongod
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# start postgres & create db/user for sentry
RUN service postgresql start && \
    su postgres sh -c "createdb sentry" && \
    su postgres sh -c "createuser --no-createdb --encrypted --no-createrole --no-superuser sentry" && \
    su postgres sh -c "psql -c \"ALTER USER sentry WITH PASSWORD 'sentry';\" " && \
    su postgres sh -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE sentry to sentry;\" " && \
    sentry --config=/sentry.conf.py upgrade --noinput

# ports for ssh/sentry
EXPOSE 22 9000

# run supervisord in foreground
CMD ["/usr/bin/supervisord", "--nodaemon"]

docker-sentry-postgres
======================

A Dockerfile that installs the latest
[sentry](https://github.com/getsentry/sentry) and postgresql as database.

Install
-------

````bash
# get the latests version
$ git clone https://github.com/ekalinin/docker-sentry-postgres.git
$ cd docker-sentry-postgres

# edit sentry's domain name (SENTRY_URL_PREFIX)
$ vim conf/sentry.conf.py

# build the docker image
$ make build

# run docker's container
$ make run
````

Usage
-----

### List ports

````bash
$ make show-running 
deecd0e16623        docker-sentry-postgres:latest   /usr/bin/supervisord   19 minutes ago      Up 19 minutes       49170->22, 49171->9000
````

### Check Sentry's UI

````bash
➥ curl -I sentry.example.com:49171
HTTP/1.1 302 FOUND
Server: gunicorn/0.17.4
Date: Tue, 22 Oct 2013 08:11:14 GMT
Connection: close
Transfer-Encoding: chunked
Vary: Accept-Language, Cookie
Content-Type: text/html; charset=utf-8
Location: http://sentry.example.com:49171/login/
Content-Language: en-us
Set-Cookie:
sessionid="gAJ9cQFVBV9uZXh0cQJYAQAAAC9zLg:1VYX3a:JimiNbGUTB0pAaurju2Rd2CfEio"; expires=Tue, 05-Nov-2013 08:11:14 GMT; httponly; Max-Age=1209600; Path=/
````

### Connect via shh

````bash
# see Dockerfile for root's password
$ make ssh 
root@127.0.0.1's password: 
Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.8.0-19-generic x86-64)

 * Documentation:  https://help.ubuntu.com/
Last login: Tue Oct 22 08:01:19 2013 from example.com
root@deecd0e16623:~# 
````

#### Sentry's seuperuser creation

````bash
root@deecd0e16623:~# /usr/local/bin/sentry --config=/sentry.conf.py createsuperuser
````

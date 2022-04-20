# Elephantbox: Production Grade PHP + Node Based On Phusion

Elephantbox is a Docker image for running containerized PHP applications. It follows the
Docker philosophy of organizing an application as **logical services** and as such, the `web`
image will run nginx + php-fpm to expose your web application. Node JS is available for the
purpose of building web assets for your PHP applications.

Elephantbox in either a `docker-compose`-able service image or a `Dockerfile` baseimage:

- a development time runnable service image
- a production time image
- a parent / baseimage

Elephantbox is built on [phusion](https://github.com/phusion/baseimage-docker) and uses
apt-get to install nginx (ubuntu stock) and Ondřej Surý's PHP build.

## Quick Install

Create a `docker-compose.yaml` file in the root of your project:

```
version: '3.7'

services:

  web:
    image: elephantbox/elephantbox:latest
    command: run-services nginx,php-fpm
    environment:
      APP_NAME: my-project-name
      APP_ENV: local
    ports:
      - 8000:80
    volumes:
      - .:/app
```

Then, start the project and visit it at http://localhost:8000

```
docker-compose up -d
```

## Documentation To Be Written

- using xdebug
- command line helper
- cron jobs
- entering the shell
- using a different `my_init` command
- run-services
- transition to scalable baseimage (k8s deployments)

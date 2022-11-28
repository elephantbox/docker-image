# Elephantbox: Production Grade PHP + Node Based On Phusion

See the main readme here: https://github.com/elephantbox

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

Then, start the project:

```
docker-compose up -d
```

Finally visit it at http://localhost:8000

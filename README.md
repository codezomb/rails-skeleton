This is my Ruby on Rails API skeleton. It is used when I spin up a new Ruby on Rails project and to keep track of my standards and best practices. To use this repo, clone the repo and make any necessary changes.

Parts:

- `services/frontend` - Nginx web server. Setup with Vue.js and Vite as the builder.
- `services/backend` - Ruby on Rails, API only. Setup with Devise and Swagger.
- `services/mail` - [Mailpit](https://mailpit.axllent.org/) for viewing emails during development.

## Getting Started

### Start the environment

The following script is a convenience script to setup and launch the various services into a running state. Once the script finishes you should have a fully functional development environment.

```shell
docker-compose up -d [--build]
docker compose exec backend rails db:prepare
```

#### Verify running services

To view the running services you can run the ps command and you should be presented with a table output:

```shell
docker compose ps
```

```
NAME             COMMAND                  SERVICE    CREATED          STATUS
hydra-backend-1  "/work/bin/entrypoin…"   backend    15 seconds ago   Up 14 seconds
hydra-mail-1     "/mailpit"               mail       15 seconds ago   Up 14 seconds
hydra-postgres-1 "docker-entrypoint.s…"   postgres   15 seconds ago   Up 14 seconds
hydra-redis-1    "docker-entrypoint.s…"   redis      15 seconds ago   Up 14 seconds
hydra-vite-1     "/work/bin/entrypoin…"   vite       15 seconds ago   Up 14 seconds
```

#### View logs for a service

In order to get tailing log output from the service run the following command:
https://docs.docker.com/compose/reference/logs/

```shell
docker compose logs --follow <service name>
```

#### Shell into a service

In order to gain shell access to a service run the following:
https://docs.docker.com/compose/reference/exec/

```shell
docker compose exec <service name> bash
```

#### Stop all services
To stop all services run the following:
https://docs.docker.com/compose/reference/stop/

```shell
docker compose stop
```

## Development

### Web Interface

[Vite Ruby](https://vite-ruby.netlify.app) is used to compile the interface, typical asset pipeline is disabled. The Vite vue plugin is installed by default, and HMR is setup. The vite dev server is run inside the `vite` service in docker-compose.

The web interface can be reached by visiting `http://localhost` or you can configure a domain and pass it in via Rails credentials environment variable.

### API Documentation

[rswag](https://github.com/rswag/rswag) is used to keep api documentation up-to-date. To access the api locally you can hit http://localhost/api/docs/

To update the API documentation all you need to do is update/add the respective schema in `services/backend/swagger/<version>/schemas/`

Then run `SWAGGER_DRY_RUN=0 rake swaggerize` to generate the api documentation at `/api/docs`.

### Mail

[Mailpit](https://mailpit.axllent.org/) is used to capture outgoing emails and display them. You can view the mail inbox at `http://localhost:8025`

### Testing

Unit and requests testing is done on all API services and code coverage is expected to stay above 98% at all times. [simplecov](https://github.com/simplecov-ruby/simplecov) is used to calculate the coverage totals and generate reports. Anything below 98% coverage will trigger a failing build.

All tests suites are run using [Github actions](https://github.com/features/actions). The configuration for the suites is located in the `.github` folder.

### Quality

Services use [rubocop](https://rubocop.org/) in order to ensure a consistent and maintainable code base.

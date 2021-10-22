# PostgREST Heroku

Run [PostgREST](https://postgrest.org) on [Heroku](https://heroku.com) behind Nginx and Basic HTTP authentication.

## Getting started

First, clone this repository:

```bash
git clone git@github.com:rhubarbgroup/postgrest-heroku.git
```

Next, create a new app on Heroku:

```bash
heroku create [APP] # --region=us --team=[TEAM]

heroku stack:set container

heroku addons:create heroku-postgresql:hobby-dev

heroku config:set AUTH_USER=picard
heroku config:set AUTH_PASS=Picard-Epsilon-7-9-3
```

Push the code to the Heroku repo:

```bash
git push heroku main
```

Now go test your PostgREST app:

```bash
heroku open
```

## Configuration

The Heroku app will have the following Config Vars:

- `AUTH_USER`: The basic auth user (default: `admin`)
- `AUTH_PASS`: The basic auth password (default: `password`)
- `DATABASE_URL`: The connection PostgreSQL URL
- `PGRST_DB_POOL`: Number of connections to keep open in the pool (default: `10`)
- `PGRST_DB_SCHEMA`: The database schema to expose to REST clients (default `public`)

There is no `DB_ANON_USER` and `DB_URI`, we're using Heroku's `DATABASE_URL`.

## Development

The `docker-compose.yml` can be used to run everything locally at `http://localhost:8080/`:

```
docker-compose up --build --force-recreate
```

# devenv

A Docker-based development environment built on Ubuntu 24.04. Preinstalled inside: Node.js 25, Bun, git, ngrok, tmux, Claude Code, and global npm packages (`pm2`, `serve`, `dotenv`, `kill-port`, `rimraf`, `http-server`).

The container runs indefinitely (`sleep infinity`); you work inside it via `docker compose exec`. Container port `60050` is mapped to host port `80`.

## Running locally (without Docker Hub)

The root [docker-compose.yaml](docker-compose.yaml) builds the image from the local [Dockerfile](Dockerfile) — no Docker Hub publishing required.

```bash
# build the image and start the container in the background
docker compose up -d --build

# enter the container
docker compose exec app bash

# stop
docker compose down
```

The current directory is mounted into `/app` inside the container, so all project files are available immediately and changes are visible on both sides.

## Rebuilding from scratch (bypassing the cache)

If you need a guaranteed fresh environment (e.g. to update package versions that Docker has cached in layers):

```bash
# rebuild the image, ignoring all layer cache
docker compose build --no-cache

# recreate the container from the new image
docker compose up -d --force-recreate
```

For a full cleanup, including the old image and volumes:

```bash
docker compose down --rmi local --volumes
docker compose up -d --build
```

## Running from the prebuilt image (Docker Hub)

The [config/docker-compose.yaml](config/docker-compose.yaml) file does not build the image; it pulls the published `tripolskypetr/devenv` from Docker Hub:

```yaml
services:
  app:
    image: tripolskypetr/devenv
    platform: linux/amd64
    volumes:
      - "./:/app"
```

Put this in the root of your project on windows and you will be able to jam into the linux host with claude installation on the same machine

```bash
docker compose up -d
docker compose exec app bash
```

# snapshot-infra
Infra repo for easy development for snapshot project

## Prerequisites
You need to have docker and docker-compose installed on your machine. Make sure that you have installed them without sudo. If you have installed them with sudo, you need to run:
```sh
sudo groupadd docker
sudo usermod -aG docker $USER
```
and then relogin to your system.

## Getting Started
The simplest way to get started is to run:
```sh
./scripts/deploy.sh # this will clone all snapshot repos
```
Ask your teammates about sensitive data, stored in `.env.<service name>.local` files. You need to copy them to `envs` folder. After that you need to run:
```sh
docker compose up -d # this will run the infra
```
After that you can access snapshot at `http://localhost:3002`

## Configuration

### Custom paths
If you already have snapshot repos cloned somewhere and you don't want to close all repos again, then you can configure paths to them in `.env` file. And after that run:
```sh
docker compose up -d
```
Make sure that all repos have `.env` file in their root folder (even if it's empty).

### Custom envs
You can configure custom envs in `envs` folder. For example, you can change `DATABASE_URL` or `IPFS_GATEWAY` and it allow you to redirect requests to custom services. You can also add new envs, e.g. `IPFS_GATEWAY_2=http://localhost:8080` and use it in your repos.
If you have already run container and you want to apply changes in `.env` file, you need to run:
```sh
docker compose down
docker compose up -d
```
or
```sh
docker compose up -d --force-recreate <service name>
```
You can also temporary override envs in container by running:
```sh
docker exec -it -e <env name>=<env value> <service name> sh
```

### Fixtures and schemas
You can add fixtures to `mysql/fixtures/<service name>` folder. They will be automatically loaded during database creation. If you want to recreate database with newerly added fixtures, you need to run:
```sh
docker compose down mysql
docker volume rm snapshot-infra_mysql
docker-compose up -d mysql
```
If you want to add a new schema, you need to add the path to the new schema in `docker-compose.yml` file in `mysql` service. And then run:
```sh
docker compose down mysql
docker volume rm snapshot-infra_mysql
docker-compose up -d mysql
```

### Advanced configuration

If you don't need some services at all or you want to configure them completely differently, you can do it in `docker-compose.local.yml` file. Just copy `docker-compose.yml` to `docker-compose.local.yml` and make changes in it. After that you need to run:
```sh
docker compose -f docker-compose.local.yml up -d
```
You also can define custom `.env` file. For this you need to copy `.env` file to `.env.local` and make changes in it. After that you need to run:
```sh
docker compose -f docker-compose.local.yml --env-file .env.local up -d
```
You can find examples in `docker-compose.local.yml.example` and `.env.local.example` files.

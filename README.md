# snapshot-infra
Infra repo for easy development for snapshot project

## Prerequisites
You need to have docker and docker-compose installed on your machine.

## Getting Started
To get started, first clone this repo and then properly configure paths in `.env` file to your local snapshot repos. Additionally, you can also configure envs in `envs` folder.
than run:
```sh
./db_init.sh
```
This will fetch schemas from snapshot repos and create configure them for automatic creation of tables. Files will be placed in `schemas` folder.

## Running
To run the infra, simply run:
```sh
docker-compose up
```
## Notes:
For working with this package now (without waiting for all services add needed files), you can check branch `feat/indep-way`.

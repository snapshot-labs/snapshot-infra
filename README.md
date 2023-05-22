# snapshot-infra
Infra repo for easy development for snapshot project

## Prerequisites
You need to have docker and docker-compose installed on your machine.

## Getting Started
To get started, first clone this repo and then properly configure paths in `.env` file to your local snapshot repos. Additionally, you can also configure envs in `envs` folder.
than run:
```sh
./scripts/db_init.sh
```
This will fetch schemas from snapshot repos and create configure them for automatic creation of tables. Files will be placed in `schemas` folder.

## Running
To run the infra, simply run:
```sh
docker-compose up
```

## Independent mode
Until all those PRs will be accepted:

1. [snapshot-hub](https://github.com/snapshot-labs/snapshot-hub/pull/588)
2. [snapshot](https://github.com/snapshot-labs/snapshot/pull/3915)
3. [snapshot-sequencer](https://github.com/snapshot-labs/snapshot-sequencer/pull/50)
4. [keycard](https://github.com/snapshot-labs/keycard/pull/4)
5. [snapshot-relayer](https://github.com/snapshot-labs/snapshot-relayer/pull/97)
6. [envelop](https://github.com/snapshot-labs/envelop/pull/48)
7. [envelop-ui](https://github.com/snapshot-labs/envelop-ui/pull/6)
8. [score-api](https://github.com/snapshot-labs/score-api/pull/749)

The infra will not work properly with all branches. To run it in independent mode, you need to:
1. run `./scripts/deploy_independent_m.sh <path/to/folder(optional)>` to deploy infra to all your packages
2. run `./scripts/db_init.sh` to fetch schemas
3. update `.env` file and `envs` folder if needed
4. install git submodules if needed (should be done manually), e.g. `snapshot` repo needs `snapshot-spaces` submodule
5. run `docker-compose up` to run the infra

When PR will be accepted you need run `./scripts/revoke_independent_m.sh <path/to/your/package>` before pulling changes from upstream.

Independent mode is not recommended, but it's the only way to run infra until all PRs will be accepted. What independent mode does:
1. closens all your repositories
2. adds `.dockerignore` and `Dockerfile` to your packages
3. adds `.dockerignore` and `Dockerfile` to `.git/info/exclude` of your packages

When all PRs will be accepted, you can run `./scripts/revoke_independent_m.sh <path/to/your/package>` for all your packages to remove all changes made by `./scripts/deploy_independent_m.sh` script. And you need to switch to `master` branch of `snapshot-infra` repo.

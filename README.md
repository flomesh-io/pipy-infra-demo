
## How to use

## Node Image

```shell
TAG=0.4.0-205
docker build -t docker.io/flomesh/pipy-node:$TAG .
docker push docker.io/flomesh/pipy-node:$TAG
```

## Init env

1. `kubectl apply -f kubernetes/discovery.yaml` and wait container up.
2. `kubectl apply -f kubernetes/config.yaml` and wait container up.

## Run demo
1. `kubectl apply -f kubernetes/ratings.yaml`
2. copy pod name

## Test

TODO
### init codebase
1. Update pipy repo address in `init-repo.sh`. Not required with remote pipy repo (http://hk.flomesh.cn:6060).
2. Execute `init-repo.sh [POD_NAME]` will create new repo and initialize with scripts, as well config.

## How to use

## init env

1. `kubectl apply -f discovery.yaml` and wait container up.
2. `kubectl apply -f config.yaml` and wait container up.

## run demo
1. `kubectl apply -f ratings.yaml`
2. copy pod name

### init codebase
1. Update pipy repo address in `init-repo.sh`. Not required with remote pipy repo (http://hk.flomesh.cn:6060).
2. Execute `init-repo.sh [POD_NAME]` will create new repo and initialize with scripts, as well config.
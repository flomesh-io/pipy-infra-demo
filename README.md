
## How to use

## Node Image

```shell
TAG=0.4.0-205
docker build -t docker.io/flomesh/pipy-node:$TAG .
docker push docker.io/flomesh/pipy-node:$TAG
```

## Repalce infra container image

### 1. k3s in host

TODO
### 2. k3s in docker via k3d

```shell
$ k3d cluster create infra-test --k3s-arg "--pause-image=flomesh/pipy-node:0.4.0-205"@
```

## Init env

1. Execute `kubectl apply -f kubernetes/discovery.yaml` and wait container up.
2. Execute `kubectl apply -f kubernetes/config.yaml` and wait container up.
3. Go to [test part](./README.md#TEST), follow steps and you will get "CONFIG-SERVICE" only in output.

## Run demo

In [kubernetes/springboot/pod.yaml](./kubernetes/springboot/pod.yaml), we have disabled service discovery by injecting few environments.

1. Execute `kubectl apply -f kubernetes/springboot/pod.yaml`.
2. Execute `kubectl get po samples-bookinfo-ratings -o json > scripts/config/pod.json`

### Init codebase
1. Update pipy repo address in `init-repo.sh`. Not required with remote pipy repo (http://hk.flomesh.cn:6060).
2. Execute `init-repo.sh [POD_NAME]` (here pod name is samples-bookinfo-ratings) will create new repo and initialize with scripts, as well config.

## Test

Check the instance registerd in eureka server by shell into discovery pod:

```shell
$ kubectl exec -it samples-discovery-server-6d67944757-4nrvv -- sh
$ apk add curl jq
$ curl -s localhost:8761/eureka/apps -H accept:application/json | jq -r .applications.application[].name
```

If all working fine, you will get:

```
CONFIG-SERVICE
BOOKINFO-RATINGS
```



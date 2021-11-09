#!/usr/bin/env bash

set -exu
#### local use
# REPO_HOST=localhost:6060
# REPO_NAME=infra
#### remote repo
REPO_HOST=hub.flomesh.cn:6060
REPO_NAME=pod/$1

#create repo
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME
#main
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME/main.js --data-binary '@./scripts/main.js'
#config
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME/config/eureka.json --data-binary '@./scripts/config/eureka.json'
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME/config/main.json --data-binary '@./scripts/config/main.json'
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME/config/pod.json --data-binary '@./scripts/config/pod.json'
#plugins
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME/plugins/log.js --data-binary '@./scripts/plugins/log.js'
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME/plugins/eureka.js --data-binary '@./scripts/plugins/eureka.js'
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME/plugins/proxy.js --data-binary '@./scripts/plugins/proxy.js'

#release
curl -X POST http://$REPO_HOST/api/v1/repo/$REPO_NAME --data '{"version": 2}'


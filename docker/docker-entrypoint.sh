#!/bin/sh

set -exu

export POD_NAME=`hostname`

if [[ $POD_NAME == controller-manager-pifr* ]]; then
  exec pipy scripts/pause.js
else  
  if [[ "$1" == "pipy" ]]; then
    if [[ "$2" == "node-start" ]]; then
      shift 2
        while true; do 
        echo "Trying to connect to repo http://pipy-repo.pipy-infra.svc:6060/repo/pod/${POD_NAME}/  ..."
        exec pipy http://pipy-repo.pipy-infra.svc:6060/repo/pod/${POD_NAME}/ --admin-port=6061
        if [[ $? -ne 0 ]]; then
          echo "Trying to connect to repo http://pipy-repo.pipy-infra.svc:6060/repo/pod/${POD_NAME}/  ..."
          exec pipy http://pipy-repo.pipy-infra.svc:6060/repo/pod/${POD_NAME}/ --admin-port=6061
        fi
        sleep 2
        done
    fi
  fi
fi

exec "$@"

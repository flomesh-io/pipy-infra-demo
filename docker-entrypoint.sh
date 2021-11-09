#!/bin/sh

set -e

export POD_NAME=`hostname`

if [[ "$1" == "pipy" ]]; then
  if [[ "$2" == "node-start" ]]; then
    shift 2
      while true; do 
       echo "Trying to connect to repo http://hub.flomesh.cn:6060/repo/pod/${POD_NAME}/  ..."
       pipy http://hub.flomesh.cn:6060/repo/pod/${POD_NAME}/ || RET=$?
       if [[ $? -ne 0 ]]; then
         echo "Trying to connect to repo http://hub.flomesh.cn:6060/repo/pod/${POD_NAME}/  ..."
         pipy http://hub.flomesh.cn:6060/repo/pod/${POD_NAME}/ || RET=$?
       fi
      sleep 2
      done
  fi
fi

exec "$@"

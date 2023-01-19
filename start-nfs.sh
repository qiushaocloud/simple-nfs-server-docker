#!/bin/bash

echo "exports info:"
cat /etc/exports

set -uo pipefail

while true; do
  pid=`pidof rpc.mountd`
  while [ -z "$pid" ]; do
    echo "run /sbin/rpcbind -w"
    /sbin/rpcbind -w
    echo "run /sbin/rpcinfo"
    /sbin/rpcinfo

    echo "start rpc.nfsd"
    /usr/sbin/rpc.nfsd --debug 8 --no-udp --no-nfs-version 2 --no-nfs-version 3
   
    echo "run /usr/sbin/exportfs -rv"
    if /usr/sbin/exportfs -rv; then
      echo "run /usr/sbin/exportfs"
      /usr/sbin/exportfs
    else
      echo "export validation failed, need exit"
      exit 1
    fi

    echo "start rpc.mountd"
    /usr/sbin/rpc.mountd --debug all --no-udp --no-nfs-version 2 --no-nfs-version 3

    pid=`pidof rpc.mountd`
    if [ -z "$pid" ]; then
      echo "start rpc.mountd failed, sleep 5s, retry"
      sleep 5
    fi
  done

  echo "run success"
  break
done

while true; do
  pid=`pidof rpc.mountd`
  if [ -z "$pid" ]; then
    echo "NFS run failed, need exit"
    exit 1
  fi

  sleep 5
done

sleep 1
exit 1
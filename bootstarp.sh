#!/bin/bash

echo "start server"
/etc/init.d/nfs-kernel-server start

while true; do
  echo "check ...."
  sleep 300
done
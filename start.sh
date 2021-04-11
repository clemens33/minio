#!/bin/bash

cd ~/docker/minio

export MINIO_STORAGE_LOCATION=~/data/minio
export MINIO_PORT=9001
export MINIO_CONSOLE_PORT=9091
export MINIO_ROOT_USER=minio
export MINIO_ROOT_PASSWORD=minio123

ln -s $MINIO_STORAGE_LOCATION ./data

docker-compose pull
docker-compose up --remove-orphans -d

mc='docker exec -it minio-client mc'

# create console user and policy
export MINIO_CONSOLE_USER=console
export MINIO_CONSOLE_PASSWORD=console123
$mc admin user add minio/ $MINIO_CONSOLE_USER $MINIO_CONSOLE_PASSWORD
$mc admin policy add minio/ consoleAdmin /root/.mc/admin.json
$mc admin policy set minio consoleAdmin user=$MINIO_CONSOLE_USER



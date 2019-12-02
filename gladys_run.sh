#!/bin/bash

echo "Création du réseau 'gladys-net'"
docker network create gladys-net

echo "Lancement du container Gladys"
docker run -d \
      --restart=always \
      --privileged \
      --network=gladys-net \
      --name gladys-zigbee2mqtt \
      -p 80:80 \
      -e NODE_ENV=production \
      -e SERVER_PORT=80 \
      -e TZ=Europe/Paris \
      -e SQLITE_FILE_PATH=/var/lib/gladysassistant/gladys-production.db \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v ${PWD}/gladysassistant:/var/lib/gladysassistant \
      -v /dev:/dev \
      r6n0/gladys-zigbee2mqtt:4.0.0-beta-arm
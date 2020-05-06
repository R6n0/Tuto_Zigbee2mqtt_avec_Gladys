#!/bin/bash

docker run -d \
    --restart=always \
    --network=gladys-net \
    --name mqtt4z2m \
    -p 1883:1883 \
    eclipse-mosquitto

docker stop mqtt4z2m
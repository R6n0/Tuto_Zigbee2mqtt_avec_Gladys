#!/bin/bash

docker run -d \
    --restart=always \
    --network=gladys-net \
    --name mqtt-broker \
    -p 1883:1883 \
    eclipse-mosquitto

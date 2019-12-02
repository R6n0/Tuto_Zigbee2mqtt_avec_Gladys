#!/bin/bash

echo "Lancement de Gladys"
./gladys_run.sh

echo 
echo "Lancement du broker MQTT"
./mqtt_run.sh

echo
echo "Lancement de Zigbee2mqtt"
./zigbee2mqtt_run.sh

echo
echo "Gladys avec Zigbee2mqtt démarré !"
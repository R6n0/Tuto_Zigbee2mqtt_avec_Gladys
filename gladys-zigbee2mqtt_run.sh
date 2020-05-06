#!/bin/bash

echo "Création du réseau 'gladys-net'"
docker network create gladys-net

echo "Lancement de Gladys"
./gladys_run.sh

echo 
echo "Création du container MQTT"
./mqtt_run.sh

echo
echo "Création du container Zigbee2mqtt"
./zigbee2mqtt_run.sh

echo
echo "Gladys démarré !"
echo "Pour lancer Zigbee2mqtt, se connecter à Gladys"
echo "et aller à la page Integrations/Zigbee2mqtt/Setup"
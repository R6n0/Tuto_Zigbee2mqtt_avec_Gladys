#!/bin/bash

# On recherche le dongle CC2531
echo "Recherche de l'interface du dongle CC2531"
for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
        syspath="${sysdevpath%/dev}"
        devname="$(udevadm info -q name -p $syspath)"
        [[ "$devname" == "bus/"* ]] && continue
        eval "$(udevadm info -q property --export -p $syspath)"
        [[ -z "$ID_SERIAL" ]] && continue
        if [ $(grep "CC2531" <<<$ID_SERIAL) ]; then
                DONGLE=CC2531;
                TTY=/dev/$devname;
                echo "$TTY - $DONGLE"
        else
                if [ $(grep "CC2530" <<<$ID_SERIAL) ]; then
                        DONGLE=CC2530;
                        TTY=/dev/$devname;
                        echo "$TTY - $DONGLE"
                fi
        fi
done

# On créé le fichier de configuration de Zigbee2mqtt
echo "Configuration de Zigbee2mqtt"
[ -d "zigbee2mqtt/data" ] && mkdir -p zigbee2mqtt/data
cat <<EOF > zigbee2mqtt/data/configuration.yaml
homeassistant: false
permit_join: true
mqtt:
  base_topic: zigbee2mqtt
  server: 'mqtt://mqtt-broker'
serial:
  port: /dev/ttyACM0
EOF

# On lance le container Zigbee2mqtt
echo "Lancement du container Zigbee2mqtt"
docker run -d \
    --restart=always \
    --network=gladys-net \
    --name zigbee2mqtt \
    -v ${PWD}/zigbee2mqtt/data:/app/data \
    --device=$TTY:/dev/ttyACM0 \
    koenkk/zigbee2mqtt

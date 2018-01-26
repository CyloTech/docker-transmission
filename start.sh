#!/bin/bash

mkdir -p /torrents/completed
mkdir -p /torrents/downloading
mkdir -p /torrents/watch
mkdir -p /torrents/config/transmission

if [ ! -f /config/settings.json ]; then
    mv /etc/transmission-daemon/settings.json /torrents/config/transmission/settings.json
    rm /var/lib/transmission-daemon/info/settings.json
else
    rm /var/lib/transmission-daemon/info/settings.json
    rm /etc/transmission-daemon/settings.json
fi

ln -sf /torrents/config/transmission/settings.json /var/lib/transmission-daemon/info/settings.json
ln -sf /torrents/config/transmission/settings.json /etc/transmission-daemon/settings.json

sed -i "s/TR_USER/${USERNAME}/g" /torrents/config/transmission/settings.json
sed -i "s/TR_PASS/${PASSWORD}/g" /torrents/config/transmission/settings.json

chown -R 1000:1000 /torrents

/usr/bin/transmission-daemon --foreground --config-dir /torrents/config/transmission --log-info --username ${USERNAME} --peerport 45555 --password ${PASSWORD} --auth --watch-dir /torrents/watch --download-dir /torrents/completed --incomplete-dir /torrents/downloading

#!/bin/bash

# if default config is present, move it to /config
# this is just to make it easier to edit it on the host machine
if [[ -f /home/nobody/rtorrent.rc && ! -f /config/rtorrent.rc ]]; then
    echo "[info] Moving rtorrent.rc to /config/"
    mv /home/nobody/rtorrent.rc /config/
fi

echo "[info] Getting listen port..."

source /home/nobody/getport.sh

echo "[info] All checks complete, starting rtorrent..."

# run rtorrent
rtorrent -n -o import=/config/rtorrent.rc -o port_range=$PIA_INCOMING_PORT-$PIA_INCOMING_PORT

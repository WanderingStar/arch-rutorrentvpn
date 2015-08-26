#!/bin/bash

# if rtorrent is not using the correct PIA port, kill rtorrent
# this doesn't appear to be necessary

# wait for rtorrent to start (listen for port)
while [[ $(netstat -lnt | awk '$6 == "LISTEN" && $4 ~ ".5000"') == "" ]]; do
	sleep 0.1
done

while true
do

	source /home/nobody/getport.sh

	# lookup the currently set rtorrent incoming port
	RTORRENT_INCOMING_PORT=`/usr/bin/xmlrpc2scgi.py scgi://127.0.0.1:5000 get_port_range | perl -ne 'print "$1\n" if m/<string>(\d+)[-<]/'`

	echo "[info] rTorrent incoming port $RTORRENT_INCOMING_PORT"

	if [[ $RTORRENT_INCOMING_PORT != "$PIA_INCOMING_PORT" ]]; then

		echo "[info] $RTORRENT_INCOMING_PORT != $PIA_INCOMING_PORT, stopping"
	
		pkill rtorrent

	else

		sleep 50m
	
	fi

done

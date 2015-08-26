#!/bin/bash

# create pia client id (randomly generated)
CLIENT_ID=`head -n 100 /dev/urandom | md5sum | tr -d " -"`

# run script to check/get ip for tun0
source /home/nobody/checkip.sh

# get username and password from credentials file
USERNAME=$(sed -n '1p' /config/openvpn/credentials.conf)
PASSWORD=$(sed -n '2p' /config/openvpn/credentials.conf)

# lookup the dynamic pia incoming port (response in json format)
PIA_INCOMING_PORT=`curl --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 120 -s -d "user=$USERNAME&pass=$PASSWORD&client_id=$CLIENT_ID&local_ip=$LOCAL_IP" https://www.privateinternetaccess.com/vpninfo/port_forward_assignment | head -1 | grep -Po "[0-9]*"`

echo $PIA_INCOMING_PORT
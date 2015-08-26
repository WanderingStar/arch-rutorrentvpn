rTorrent + ruTorrent + OpenVPN + Privoxy
==========================

rTorrent - https://github.com/rakshasa/rtorrent
ruTorrent - https://github.com/Novik/ruTorrent
OpenVPN - https://openvpn.net/
Privoxy - http://www.privoxy.org/

Latest stable rTorrent release for Arch Linux with ruTorrent web front end, including OpenVPN to tunnel torrent traffic securely (using iptables to block any traffic not bound for tunnel). This now also includes Privoxy to allow unfiltered http|https traffic via VPN.

Based on https://github.com/binhex/arch-delugevpn

**Pull image**

```
docker pull binhex/arch-delugevpn
```

**Run container**

```
docker run -d --cap-add=NET_ADMIN -p 9092:9092 -p 8118:8118 --name=<container name> -v <path for data files>:/data -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro -e VPN_ENABLED=<yes|no> -e VPN_USER=<vpn username> -e VPN_PASS=<vpn password> -e VPN_REMOTE=<vpn remote gateway> -e VPN_PORT=<vpn remote port> -e VPN_PROV=<pia|airvpn|custom> -e ENABLE_PRIVOXY=<yes|no> binhex/arch-rutorrentvpn
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access ruTorrent**

```
http://<host ip>:9092
```

**Access Privoxy**

```
<host ip>:8118
```

Default is no authentication required

**PIA user**

PIA users will need to supply VPN_USER and VPN_PASS, optionally define VPN_REMOTE (list of gateways https://www.privateinternetaccess.com/pages/client-support/#signup) if you wish to use another remote gateway other than the Netherlands. You'll want to choose one that supports port forwarding.

**Example**

```
docker run -d --cap-add=NET_ADMIN -p 9092:9092 -p 8118:8118 --name=rutorrentvpn -v /root/docker/data:/data -v /root/docker/config:/config -v /etc/localtime:/etc/localtime:ro -e VPN_ENABLED=yes -e VPN_USER=myusername -e VPN_PASS=mypassword -e VPN_REMOTE=nl.privateinternetaccess.com -e VPN_PORT=1194 -e VPN_PROV=pia -e ENABLE_PRIVOXY=yes binhex/arch-rutorrentvpn
```

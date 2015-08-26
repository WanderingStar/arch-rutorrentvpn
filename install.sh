#!/bin/bash

# exit script if return code != 0
set -e

# define pacman packages
pacman_packages="vim unzip unrar librsvg pygtk python2-service-identity python2-mako python2-notify rtorrent php-apache wget"

# install pre-reqs
pacman -Sy --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# set permissions
chown -R nobody:users /home/nobody # /usr/bin/deluged /usr/bin/deluge-web
chmod -R 775 /home/nobody # /usr/bin/deluged /usr/bin/deluge-web

wget http://dl.bintray.com/novik65/generic/rutorrent-3.6.tar.gz
wget http://dl.bintray.com/novik65/generic/plugins-3.6.tar.gz
mkdir -p /srv/http/plugins
tar -C /srv/http --strip-components=1 -zxvf rutorrent-3.6.tar.gz
tar -C /srv/http -zxvf plugins-3.6.tar.gz
rm rutorrent-3.6.tar.gz
rm plugins-3.6.tar.gz

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*

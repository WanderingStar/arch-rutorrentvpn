FROM binhex/arch-openvpn
MAINTAINER aneel

# additional files
##################

# add supervisor conf file for app
ADD rutorrent.conf /etc/supervisor/conf.d/

# add bash scripts to install app, and setup iptables, routing etc
ADD *.sh /root/

# add bash script to run deluge
ADD apps/nobody/*.sh /home/nobody/

# add rtorrent.rc in /home/nobody
ADD rtorrent.rc /home/nobody/

# add xmlrpc2scgi.py in /usr/bin
ADD xmlrpc2scgi.py /usr/bin/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/nobody/*.sh && \
	/bin/bash /root/install.sh

# replace default httpd.conf
ADD httpd.conf /etc/httpd/conf/

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used to store data from app)
VOLUME /data

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]

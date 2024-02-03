#!/bin/bash

# network and printer automatic discovery
# Avahi provides local hostname resolution using a "hostname.local" naming scheme. To enable it, install the nss-mdns package and start/enable avahi-daemon.service.
# Then, edit the file /etc/nsswitch.conf and change the hosts line to include mdns_minimal [NOTFOUND=return] before resolve and dns:
# hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns

pacman -S avahi nss-mdns
systemctl enable avahi-daemon
# click/enable option mdns in firewall GUI config "services" option - for printer to work
# better yet, change default zone form public to home, which has mdns enabled bz default

# printer
# printer needs ghostscript (.pdf stuff) to print, cause it receives what to print in .pdf format
pacman -S cups ghostscript
systemctl enable cups.service

#!/bin/bash
# Hostname: the name of this computer on your network.
# /etc/hosts needs no entry for it, systemd resolves its own hostname.
[ -z "$hostname" ] && read -rp "Hostname: " hostname
echo "$hostname" > /etc/hostname

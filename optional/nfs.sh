#!/bin/bash
# NFS shares folders with other Linux machines (and Android apps) over the network.
# This sets up the server side; clients only need nfs-utils and a mount command.

sudo pacman -S --needed nfs-utils

# /etc/exports lists what you share and with whom. Example line:
#   /home/user/share  192.168.1.0/24(rw,sync,no_subtree_check)
# Use your own network instead of *, so the share isn't open on public networks.
# Add "insecure" to the options if an Android app needs to connect.
read -rp "Folder to share (Enter to skip): " folder
if [ -n "$folder" ]; then
    read -rp "Network allowed to connect (e.g. 192.168.1.0/24): " network
    echo "$folder $network(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
fi

sudo systemctl enable --now nfs-server
# Reload /etc/exports after every change and show what is shared.
sudo exportfs -arv

# NFS needs these three services open, only in the home zone.
sudo firewall-cmd --permanent --zone=home --add-service={nfs,mountd,rpc-bind}
sudo firewall-cmd --reload

# On a client:
#   showmount -e <server-ip>                         what the server shares
#   sudo mount -t nfs <server-ip>:/home/user/share /mnt
# Both clocks must be in sync (timedatectl), otherwise NFS gets very slow.

#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# NetworkManager is a graphical and command-line utility for managing network connections in Linux
# I think you don't need dhcpcd since it has it's own. Not sure though
sudo pacman -S networkmanager

# enable the NetworkManager service
systemctl enable NetworkManager


# applet to run in a panel inside DE
# pacman -S network-manager-applet # will be installed inside XFCE script



# To connect to wifi use the following commands:

# List your network cards:
# nmcli

# List all visible Wi-Fi networks:
# nmcli dev wifi list

# connect
# nmcli dev wifi connect <network_name> password <password>

# Replace <network_name> with the actual name of your Wi-Fi network. Wrap the Wi-Fi network name in " " if you use space in the name. Example: nmcli dev wifi connect "Wu Tang LAN"
# Replace <password> with the actual password of your Wi-Fi network.


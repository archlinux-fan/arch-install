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

# network (there is no other wifi tool otherwise. Use iwctl )
sudo pacman -S networkmanager

# applet to run in a panel inside DE
# pacman -S network-manager-applet # will be installed inside XFCE script


systemctl enable NetworkManager

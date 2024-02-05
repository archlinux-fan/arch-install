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

# bluetooth (needed if you use bluetooth mouse or keyboard)


# bluez package provides Bluetooth stack management
sudo pacman -S bluez

# bluez-utils package includes tools for Bluetooth management like bluetoothctl
sudo pacman -S bluez-utils

systemctl enable bluetooth

#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



# Bluetooth is needed if you use bluetooth mouse or keyboard, bluetooth headphnoes, etc.


# package provides Bluetooth stack management
sudo pacman -S bluez

# package includes tools for Bluetooth management like bluetoothctl
sudo pacman -S bluez-utils

# enable the bluetooth service
systemctl enable bluetooth

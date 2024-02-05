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


# Firewall
pacman -S firewalld 

# enable the firewalld service
systemctl enable firewalld


# mirorrs automatic sorting 
pacman -S reflector

# enable the reflector timer to run weekly
systemctl enable reflector.timer


# trim SSD drive
# enable the fstrim timer to trim SSD drive weekly
systemctl enable fstrim.timer

# sudo pacman -S mkinitcpio-firmware      # Optional firmware for the default linux kernel to get rid of the annoying 'WARNING: Possibly missing firmware for module:' messages

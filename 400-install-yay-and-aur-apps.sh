#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



git clone https://aur.archlinux.org/yay.git /tmp/yay-bin

# Once done, switch to the cloned directory:
cd /tmp/yay-bin

# Build it. Follow instructions
makepkg -si

# You can test it's version
yay --version

# mouse cursor
yay -S simple-and-soft-cursor

# theme https://aur.archlinux.org/packages/nordic-bluish-accent-standard-buttons-theme
# (regular not .git version)
yay -S nordic-bluish-accent-standard-buttons-theme

# internet
yay -S brave-bin

# music
yay -S audacious-gtk3 audacious-plugins-gtk3

# System info tools
# yay hardinfo

# yay -S ttf-ms-fonts (to get Times new roman fonts etc?)

#!/bin/bash

git clone https://aur.archlinux.org/yay.git

# Once done, switch to the cloned directory:
cd yay

# Build it. Follow instructions
makepkg -si

# You can test it's version
yay --version

# mouse cursor
yay -S simple-and-soft-cursor

# internet
yay -S brave-bin

# music
yay -S audacious-gtk3 audacious-plugins-gtk3

# System info tools
# yay hardinfo

# yay -S ttf-ms-fonts (to get Times new roman fonts etc?)

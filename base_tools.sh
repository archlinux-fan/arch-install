#!/bin/bash

# AUR
# yay
printf "install yay first! then delete this"
# add confirm or exit here


# file system
sudo pacman -S file-roller thunar thunar-archive-plugin thunar-volman

# internet
yay -S brave-bin
sudo pacman -S chromium transmission-gtk

# media
# guvcview - web-cam settings
# ristretto - image viewer
# scrot - screenshot tool
# mtpaint

sudo pacman -S guvcview mpv ristretto scrot

# Other
# rofi - tool za search/run
# mousepad - text editor
# peek - animated gif recorder
# rnote - more beautiful mtpaint
# gpick - color picker tool (I never use it)
# gsimplecal - calendar (I never use it)
sudo pacman -S rofi mousepad

# System info tools
# yay hardinfo
# sudo pacman -S neofetch
# sudo pacman -S vdpauinfo

# Office docs
# libreoffice-still

# baobab - disk tool?
# bleachbit - cleaning tool

# catfish - search tool?
# celluloid - (najbrš ne rabim - simple media player)

# firejail - za testiranje brez da si fillaš .config mapo

# galculator - calculator (I never use it)
# ghostscript - dont know


# gvfs - auto mounting disks and partitions? 
# gvfs-mtp - 

# zram-generator


# nss-mdns - dont know. For printer?
# ttf-ms-fonts 2.0-12

# music
yay -S audacious-gtk3 audacious-plugins-gtk3

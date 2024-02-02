#!/bin/bash

# file system
# gvfs - auto mounting disks and partitions? 
# gvfs-mtp - auto mounting phone
sudo pacman -S file-roller gvfs thunar thunar-archive-plugin thunar-volman

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
# bash-completion - use tab to complete words in bash
sudo pacman -S rofi mousepad bash-completion

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


# zram-generator


# nss-mdns - dont know. For printer?
# yay ttf-ms-fonts

# music
yay -S audacious-gtk3 audacious-plugins-gtk3

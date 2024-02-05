#!/bin/bash

# file system
# gvfs - auto mounting disks and partitions? 
# gvfs-mtp - auto mounting phone
pacman -S file-roller gvfs gvfs-mtp thunar thunar-archive-plugin thunar-volman

# internet
# pacman -S chromium 
pacman -S transmission-gtk

# media
# guvcview - web-cam settings
# ristretto - image viewer
# scrot - screenshot tool
# mtpaint

pacman -S guvcview mpv ristretto scrot

# Other
# rofi - tool za search/run
# mousepad - text editor
# peek - animated gif recorder
# rnote - more beautiful mtpaint
# gpick - color picker tool (I never use it)
# gsimplecal - calendar (I never use it)
# bash-completion - use tab to complete words in bash
pacman -S bash-completion mousepad rofi

# System info tools
# pacman -S neofetch
# pacman -S vdpauinfo

# Office docs
# libreoffice-still

# Other other
# baobab - disk tool?
# bleachbit - cleaning tool
# catfish - search tool?
# celluloid - (najbrš ne rabim - simple media player)
# firejail - za testiranje brez da si fillaš .config mapo
# galculator - calculator (I never use it)

# zram-generator

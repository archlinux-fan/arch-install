#!/bin/bash
# Pacman, mirrors and SSD care.

# Pacman output: colors and a table of name, old and new version for every update.
sed -i 's/^#Color/Color/; s/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf

# Reflector picks the fastest up-to-date mirrors and writes /etc/pacman.d/mirrorlist.
# The timer refreshes the list once a week, so downloads stay fast.
# Its settings are in /etc/xdg/reflector/reflector.conf.
pacman -S --needed reflector && systemctl enable reflector.timer
[ -z "$mirror_countries" ] && read -rp "Mirror countries near you (e.g. Germany,France, Enter = all): " mirror_countries
[ -n "$mirror_countries" ] && echo "--country $mirror_countries" >> /etc/xdg/reflector/reflector.conf

# fstrim tells the SSD once a week which blocks are free, which keeps it fast.
# Part of util-linux, nothing to install.
systemctl enable fstrim.timer

# paccache (from pacman-contrib) keeps only the last 3 versions of every package in
# /var/cache/pacman/pkg. Without it the cache grows until you clean it with: pacman -Sc
# pacman -S --needed pacman-contrib && systemctl enable paccache.timer

#!/bin/bash
# Desktop programs.

# foot: fast, light Wayland terminal.
sudo pacman -S --needed foot

# Thunar: file manager. The archive plugin adds "Extract here" to the right-click menu.
sudo pacman -S --needed thunar
sudo pacman -S --needed thunar-archive-plugin
# gvfs: trash, network shares and USB drives in Thunar; gvfs-mtp adds Android phones.
sudo pacman -S --needed gvfs
sudo pacman -S --needed gvfs-mtp
# xarchiver: opens and creates zip, 7z, tar ... archives.
sudo pacman -S --needed xarchiver

# Text editors: lite-xl for code, mousepad for quick notes.
sudo pacman -S --needed lite-xl
sudo pacman -S --needed mousepad

# Media: mpv plays video and audio, ristretto shows images, xpdf shows PDFs.
sudo pacman -S --needed mpv
sudo pacman -S --needed ristretto
sudo pacman -S --needed xpdf

# Torrent client.
sudo pacman -S --needed transmission-gtk
# Firewall settings window.
sudo pacman -S --needed firewall-config

# Not installed by default:
# Shows USB drives in Thunar when you plug them in and can auto-mount them.
# sudo pacman -S --needed thunar-volman
# Webcam viewer and settings (brightness, focus ...).
# sudo pacman -S --needed guvcview
# Window for rsync backups.
# sudo pacman -S --needed grsync
# Music player.
# sudo pacman -S --needed audacious
# Office suite.
# sudo pacman -S --needed libreoffice-fresh
# Disk usage in a chart.
# sudo pacman -S --needed baobab
# Calculator.
# sudo pacman -S --needed galculator
# Simple paint program.
# sudo pacman -S --needed mtpaint

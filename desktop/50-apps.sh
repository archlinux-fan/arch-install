#!/bin/bash
# Desktop programs.

# foot: fast, light Wayland terminal.
sudo pacman -S --needed foot

# Thunar: file manager. The archive plugin adds "Extract here" to the right-click menu.
sudo pacman -S --needed thunar
sudo pacman -S --needed thunar-archive-plugin
# gvfs: trash, network shares and USB drives in Thunar.
sudo pacman -S --needed gvfs
# xarchiver: opens and creates zip, 7z, tar ... archives.
sudo pacman -S --needed xarchiver

# Firefox: web browser.
sudo pacman -S --needed firefox

# Text editors: lite-xl for code, mousepad for quick notes.
sudo pacman -S --needed lite-xl
sudo pacman -S --needed mousepad

# Media: mpv plays video and audio, ristretto shows images.
sudo pacman -S --needed mpv
sudo pacman -S --needed ristretto

# Torrent client.
sudo pacman -S --needed transmission-gtk
# Firewall settings window.
sudo pacman -S --needed firewall-config

# Not installed by default:
# PDF viewer. Not needed: Firefox opens PDFs.
# sudo pacman -S --needed xpdf
# Android phones on a USB cable in Thunar (MTP). Only for that.
# sudo pacman -S --needed gvfs-mtp
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

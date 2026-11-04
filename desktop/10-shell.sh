#!/bin/bash
# Shell and command line tools.

# zsh: the shell, with better completion than bash.
# chsh makes it your login shell; it asks for your password.
sudo pacman -S --needed zsh && chsh -s /usr/bin/zsh
# Suggests the rest of a command from your history as you type (grey text, → accepts).
sudo pacman -S --needed zsh-autosuggestions
# Colors commands while you type: green = exists, red = typo.
sudo pacman -S --needed zsh-syntax-highlighting
# Fuzzy finder: Ctrl+R searches your history, Ctrl+T finds files.
sudo pacman -S --needed fzf

# git: version control, needed to clone dotfiles and AUR packages.
sudo pacman -S --needed git
# btop: system monitor for CPU, memory, disks, network and processes.
sudo pacman -S --needed btop
# jq reads JSON; used by waybar scripts.
sudo pacman -S --needed jq

# Archives: 7zip packs and unpacks .zip, .7z and most other formats
# (7z x file.zip). Thunar's "Extract here" uses it too.
sudo pacman -S --needed 7zip

# Not installed by default, uncomment what you need:
# zip and unzip: only for scripts that call them by name; 7zip does .zip too.
# sudo pacman -S --needed zip
# sudo pacman -S --needed unzip
# Copies and syncs folders, only the changed parts: backups, copies to another
# computer over ssh. Nothing on the desktop needs it.
# sudo pacman -S --needed rsync
# Converts and resizes images and PDFs from the command line (magick in.png out.jpg).
# sudo pacman -S --needed imagemagick
# Older process viewer, simpler than btop.
# sudo pacman -S --needed htop
# Shows folders as a tree.
# sudo pacman -S --needed tree
# System info with a logo, for screenshots.
# sudo pacman -S --needed fastfetch
# Scans your network for devices and open ports.
# sudo pacman -S --needed nmap
# Measures network speed between two computers.
# sudo pacman -S --needed iperf3
# dig and other DNS tools.
# sudo pacman -S --needed bind
# Syncs files with cloud storage (Google Drive, S3, WebDAV ...).
# sudo pacman -S --needed rclone

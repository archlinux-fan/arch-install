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
# stow links your dotfiles from ~/.dots into your home folder.
sudo pacman -S --needed stow
# rsync copies and syncs folders, only the changed parts.
sudo pacman -S --needed rsync
# btop: system monitor for CPU, memory, disks, network and processes.
sudo pacman -S --needed btop
# jq reads JSON; used by waybar scripts.
sudo pacman -S --needed jq

# Archives: zip/unzip for .zip, 7zip for .7z and most other formats.
sudo pacman -S --needed zip
sudo pacman -S --needed unzip
sudo pacman -S --needed 7zip

# Not installed by default, uncomment what you need:
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

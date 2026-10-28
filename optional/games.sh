#!/bin/bash
# Steam and 32-bit graphics drivers.
# Most games are 32-bit or ship 32-bit parts, which come from the multilib repo.
# It's off by default; this uncomments it in /etc/pacman.conf.
# Always sync with -Syu (full upgrade), never -Sy alone: a partial upgrade can break the system.
sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
sudo pacman -Syu

# 32-bit versions of your graphics driver. Pick the ones matching desktop/30-gpu.sh.
sudo pacman -S --needed lib32-mesa
sudo pacman -S --needed lib32-vulkan-radeon
# sudo pacman -S --needed lib32-vulkan-intel
# sudo pacman -S --needed lib32-nvidia-utils

# Steam. Windows games run through Proton: Steam → Settings → Compatibility.
sudo pacman -S --needed steam

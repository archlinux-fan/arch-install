#!/bin/bash
# Graphics drivers.
# mesa is the open source driver for AMD and Intel, including hardware video
# decoding (VA-API). Vulkan is the modern graphics API used by games and some apps.
# Check what you have with: lspci -k | grep -A2 VGA

[ -z "$gpu" ] && read -rp "Graphics: [a]md, [i]ntel or [n]vidia? " gpu
case $gpu in
a*)
    sudo pacman -S --needed mesa
    sudo pacman -S --needed vulkan-radeon
    ;;
i*)
    sudo pacman -S --needed mesa
    sudo pacman -S --needed vulkan-intel
    # Hardware video decoding on Intel.
    sudo pacman -S --needed intel-media-driver
    ;;
n*)
    # Open kernel modules, recommended by NVIDIA for RTX 20xx (Turing) and newer.
    # Older cards: see https://wiki.archlinux.org/title/NVIDIA
    sudo pacman -S --needed nvidia-open
    sudo pacman -S --needed nvidia-utils
    ;;
esac

# glxinfo and eglinfo: check which driver is in use (glxinfo -B).
sudo pacman -S --needed mesa-utils
# vainfo: check that hardware video decoding works.
# sudo pacman -S --needed libva-utils

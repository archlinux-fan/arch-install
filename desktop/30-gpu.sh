#!/bin/bash
# Graphics drivers.
# mesa is the open source driver for AMD and Intel: OpenGL for the desktop and apps,
# and hardware video decoding (VA-API). Vulkan is the newer graphics API used by games.

# lspci names the graphics chip. One maker found: that one is used. None, or two
# (laptops with NVIDIA next to Intel or AMD): you're asked and see the list.
[ -z "$gpu" ] && gpu=$(lspci | grep -iE 'vga|3d|display' | grep -ioE 'amd|intel|nvidia' | sort -fu)
if [[ -z $gpu || $gpu == *$'\n'* ]]; then
    lspci | grep -iE 'vga|3d|display'
    read -rp "Graphics: [a]md, [i]ntel or [n]vidia? " gpu
fi
case ${gpu,,} in
a*)
    sudo pacman -S --needed mesa
    # Vulkan driver. Steam needs it (optional/games.sh installs it): Windows games
    # run through Proton, which turns DirectX into Vulkan. The desktop and video don't.
    # sudo pacman -S --needed vulkan-radeon
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

# Not installed by default, only to test the driver:
# glxinfo and eglinfo: check which driver is in use (glxinfo -B).
# sudo pacman -S --needed mesa-utils
# vainfo: check that hardware video decoding works.
# sudo pacman -S --needed libva-utils

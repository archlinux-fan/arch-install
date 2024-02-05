#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



#  'intel-media-driver: backend for Intel GPUs (>= Broadwell)'
#  'libva-intel-driver: backend for Intel GPUs (<= Haswell)'
#  'libva-mesa-driver: backend for AMD and Nvidia GPUs'

printf "microcode + graphic card drivers install"
printf "sudo pacman -S amd-ucode" # cpu microcodes
printf " "
printf "sudo pacman -S mesa" # provides the DRI driver for 3D acceleration
printf "sudo pacman -S xf86-video-amdgpu" # DDX driver (which provides 2D acceleration in Xorg - not needed at all? Eric Dubois removes this) 
printf " "
printf " "
printf "sudo pacman -S intel-ucode" # intel cpu
printf "sudo pacman -S intel-media-driver" # intel integrated gpu and Arc
printf " "
printf " "
printf "sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings # nvidia grafika"
printf " "
printf " "
printf "sudo pacman -S libva-mesa-driver" # VA-API drivers
printf "sudo pacman -S mesa-vdpau" # VDPAU drivers - najbrš ne rabim sploh. Zastarela NVIDIA codecs thing
printf "sudo pacman -S libva-utils" # libva-utils
printf " "
printf " "
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"








: <<'END_COMMENT'
Mesa:

Mesa is the core open-source implementation of the OpenGL and Vulkan graphics APIs.
It provides basic 3D rendering capabilities without hardware acceleration.
It's the foundation for other packages like mesa-vdpau and libva-mesa-driver.
libva:

libva (Video Acceleration API) is an open-source library that allows applications to access hardware video acceleration features on various GPUs.
It acts as a middle layer between applications and specific driver implementations like libva-intel-driver or libva-mesa-driver.
mesa-vdpau:

mesa-vdpau is a plugin for Mesa that adds support for the VDPAU (Video Decode and Presentation API for Unix) API.
VDPAU is an older API primarily used by NVIDIA GPUs for hardware-accelerated video decoding.
It's less widely supported than VA-API but might be relevant for older NVIDIA cards.
libva-mesa-driver:

libva-mesa-driver is another plugin for Mesa that adds support for the VA-API.
This is the more modern and widely supported approach for hardware video acceleration on various GPUs, including Intel, AMD, and some NVIDIA cards.
In summary:

Mesa: Core graphics API implementation (OpenGL, Vulkan)
libva: Library for accessing hardware video acceleration features
mesa-vdpau: Plugin for Mesa supporting VDPAU (mostly NVIDIA)
libva-mesa-driver: Plugin for Mesa supporting VA-API (various GPUs)
Which one do you need?

It depends on your specific needs and hardware.
For basic 3D graphics processing, you only need Mesa.
For hardware-accelerated video decoding/encoding, you need either mesa-vdpau (older NVIDIA) or libva-mesa-driver (VA-API on various GPUs).
Consult your distribution's documentation or GPU specs to determine which option is compatible and suitable for your setup.

END_COMMENT


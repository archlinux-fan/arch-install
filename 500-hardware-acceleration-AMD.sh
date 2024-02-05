#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################


printf "Accelerated video decoding "
pacman -S libva-mesa-driver # VA-API drivers
pacman -S mesa-vdpau # VDPAU drivers

# Vulkan - ko directX, ne rabiš za youtube
# https://wiki.archlinux.org/title/Vulkan
# pacman -S vulkan-radeon # VDPAU drivers

# Hardware acceleration info: https://wiki.archlinux.org/title/Hardware_video_acceleration
# Verifying VA-API
# Verify the settings for VA-API by running vainfo, which is provided by 
pacman -S libva-utils

# Verifying VDPAU
# Install vdpauinfo to verify if the VDPAU driver is loaded correctly and retrieve a full report of the configuration:
pacman -S vdpauinfo


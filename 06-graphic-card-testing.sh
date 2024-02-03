#!/bin/bash

# Hardware acceleration info: https://wiki.archlinux.org/title/Hardware_video_acceleration
# Verifying VA-API
# Verify the settings for VA-API by running vainfo, which is provided by 
pacman -S libva-utils

# Verifying VDPAU
# Install vdpauinfo to verify if the VDPAU driver is loaded correctly and retrieve a full report of the configuration:
pacman -S vdpauinfo


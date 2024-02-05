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



# For everyday Bluetooth audio needs on Arch Linux, you mainly need:
#
# PipeWire: Installed automatically with pipewire-pulse.
# WirePlumber: Included in pipewire-pulse.
# Don't install JACK or its package unless you have a specific reason for using it in your audio workflow.


# wireplumber is the recommended session manager for PipeWire and comes included in the pipewire-pulse
pacman -S wireplumber

# PipeWire is a modern multimedia server that aims to replace PulseAudio and JACK by providing a unified platform for managing audio, video, and other media streams
pacman -S pipewire              # will be installed automatically by wireplumber

# pipewire-pulse replaces PulseAudio and provides Bluetooth support
pacman -S pipewire-pulse        # will be installed automatically by wireplumber

# jack or jack2 is not needed unless you have a specific reason for using it in your audio workflow
# pacman -S jack2               # will be installed automatically by audacity, mpv,...

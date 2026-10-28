#!/bin/bash
# Sound and Bluetooth.

# PipeWire handles all audio (and screen sharing). pipewire-pulse lets programs
# written for the older PulseAudio work with it. It starts by itself when you log in.
sudo pacman -S --needed pipewire-pulse
# WirePlumber decides where sound goes: speakers, headphones, HDMI, Bluetooth.
sudo pacman -S --needed wireplumber
# pavucontrol: volume per program and choice of output device.
sudo pacman -S --needed pavucontrol
# playerctl controls music and video players; used by the media keys.
sudo pacman -S --needed playerctl
# Extra firmware some sound cards need.
sudo pacman -S --needed alsa-firmware
# Firmware for the audio chip in many newer laptops; install it if you have no sound.
# sudo pacman -S --needed sof-firmware

# BlueZ is the Bluetooth stack, bluez-utils adds bluetoothctl.
# The service must be enabled, otherwise Bluetooth is off after every boot.
sudo pacman -S --needed bluez && sudo systemctl enable bluetooth
sudo pacman -S --needed bluez-utils
# bluetui: pair and connect devices in the terminal.
sudo pacman -S --needed bluetui

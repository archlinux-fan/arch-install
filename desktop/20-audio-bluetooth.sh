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

# BlueZ is the Bluetooth stack.
# The service must be enabled, otherwise Bluetooth is off after every boot.
sudo pacman -S --needed bluez && sudo systemctl enable bluetooth
# bluetui: pair and connect devices in the terminal.
sudo pacman -S --needed bluetui

# Not installed by default:
# Firmware for the audio chip in many newer laptops (Sound Open Firmware);
# install it if you have no sound.
# sudo pacman -S --needed sof-firmware
# Firmware for some older and pro sound cards that load it at start. Most built-in
# sound (HD Audio) and USB audio don't need it; PipeWire doesn't replace it.
# sudo pacman -S --needed alsa-firmware
# bluetoothctl, the command line Bluetooth tool. bluetui does the same in a menu.
# sudo pacman -S --needed bluez-utils

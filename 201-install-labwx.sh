#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



# Login manager
sudo pacman -S lightdm                          # Lightweight and fast login manager
sudo pacman -S lightdm-gtk-greeter              # GTK 3 greeter for lightdm
sudo pacman -S lightdm-gtk-greeter-settings     # Settings tool for lightdm-gtk-greeter

# Enable the lightdm service
sudo systemctl enable lightdm


# Network manager applet
sudo pacman -S network-manager-applet           # GTK 3 front-end for NetworkManager


# PulseAudio volume control
sudo pacman -S pavucontrol                      # Advanced sound level control


# Application termination tool
sudo pacman -S xorg-xkill                       # Allows killing applications with a mouse click


# Themes (currently not used. nordic-bluish-accent-standard-buttons-theme theme installed later from AUR is preferred)
# sudo pacman -S arc-gtk-theme                  # GTK theme set
# sudo pacman -S arc-icon-theme                 # GTK icon set(nordic installed later from AUR is preferred)


# Icons
sudo pacman -S papirus-icon-theme               # Popular icon theme


# Install labwc components
sudo pacman -S wlroots                          # needed for Wayland
yay labwc                                       # Openbox alternative for Wayland
sudo pacman -S labwc-menu-generator             # wayland menu generator
sudo pacman -S xfce4-notifyd                    # Notification daemon for Wayland
sudo pacman -S waybar                           # Main panel for Wayland
sudo pacman -S wl-clipboard                     # Clipboard manager for Wayland
sudo pacman -S xfce4-pulseaudio-plugin          # PulseAudio integration for Wayland panel
sudo pacman -S swayidle                         # Screen saver for Wayland
sudo pacman -S xfce4-screenshooter              # Screenshot tool for Wayland
sudo pacman -S lxsession                        # Session management for Wayland ali nekako z polkit
yay nwg-look                                    # Settings application for Wayland - for appearance, choose icons,..
sudo pacman -S xfce4-taskmanager                # Task manager for XFCE
sudo pacman -S foot                             # Terminal emulator for Wayland
sudo pacman -S swaybg                           # background setting for Wayland
# sudo pacman -S xfce4-time-out-plugin            # Automatic logout plugin for Wayland
sudo pacman -S xfce4-weather-plugin             # Weather plugin for Wayland panel
sudo pacman -S xfdesktop                        # Desktop environment components for Wayland
sudo pacman -S wlogout                          # Power menu for Wayland



wofi - ko rofi

grim - screenshoots
slurp, grimblast (aur)


mako - notification daemon simple (dunst alternative)
swaylock ali gtklock
swaync - notification daemon (better dunst alternative)
qt5ct + zamenjat Qt theme
eww-wayland (AUR)


wlogout - Power menu
Xava (AUR) - Audio Visualizer


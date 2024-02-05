#!/bin/bash

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
# sudo pacman -S arc-gtk-theme arc-icon-theme   # GTK icon set(nordic installed later from AUR is preferred)


# Icons
sudo pacman -S papirus-icon-theme               # Popular icon theme


# Install XFCE components
sudo pacman -S xfce4-battery-plugin             # Battery status indicator for XFCE panel
sudo pacman -S xfce4-clipman-plugin             # Clipboard manager for XFCE panel
sudo pacman -S xfce4-notifyd                    # Notification daemon for XFCE
sudo pacman -S xfce4-panel                      # Main panel for XFCE
sudo pacman -S xfce4-pulseaudio-plugin          # PulseAudio integration for XFCE panel
sudo pacman -S xfce4-screensaver                # Screen saver for XFCE
sudo pacman -S xfce4-screenshooter              # Screenshot tool for XFCE
sudo pacman -S xfce4-session                    # Session management for XFCE
sudo pacman -S xfce4-settings                   # Settings application for XFCE
sudo pacman -S xfce4-taskmanager                # Task manager for XFCE
sudo pacman -S xfce4-terminal                   # Terminal emulator for XFCE
sudo pacman -S xfce4-time-out-plugin            # Automatic logout plugin for XFCE
sudo pacman -S xfce4-weather-plugin             # Weather plugin for XFCE panel
sudo pacman -S xfdesktop                        # Desktop environment components for XFCE
sudo pacman -S xfwm4                            # Window manager for XFCE
sudo pacman -S xfwm4-themes                     # Themes for the XFWM4 window manager

# sudo pacman -S xfce4-power-manager            # Power management for laptops (not needed for desktop)



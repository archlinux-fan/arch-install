#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



# File system
sudo pacman -S file-roller              # Archiving tool for creating and managing compressed files
sudo pacman -S gvfs                     # Virtual filesystem for accessing network resources and devices
sudo pacman -S gvfs-mtp                 # Extension for gvfs to automatically mount MTP devices (like phones)
sudo pacman -S thunar                   # Lightweight and fast file manager
sudo pacman -S thunar-archive-plugin    # Thunar plugin for handling archives
sudo pacman -S thunar-volman            # Thunar plugin for managing removable devices

# Internet
# sudo pacman -S chromium                 # Open-source web browser based on the Blink rendering engine        
# yay -S brave                            # I use brave, which is installed later from AUR.Open-source web browser based on the Blink rendering engine        
sudo pacman -S transmission-gtk         # BitTorrent client with a user-friendly GTK interface

# Media
sudo pacman -S guvcview                 # Tool for viewing and adjusting webcam settings
sudo pacman -S mpv                      # Versatile media player with support for various formats
sudo pacman -S ristretto                # Simple and fast image viewer
# sudo pacman -S scrot                    # Command-line screenshot tool for capturing and saving images. I use XFCE xfce4-screenshooter
# sudo pacman -S mtpaint                  # Simple and lightweight graphical paint program
# sudo pacman -S peek                     # Tool for recording short screencasts as animated GIFs

# Tools
# sudo pacman -S rnote                    # Feature-rich and visually appealing text editor
# sudo pacman -S xcolor                   # Advanced color picker tool for selecting and manipulating colors
# sudo pacman -S gpick                    # Another lightweight X11 color picker with more color manipulation options but a less modern interface
# sudo pacman -S gsimplecal               # Simple calendar application for basic date management
# sudo pacman -S firejail                 # Sandbox tool for safely running applications by restricting the environment in which applications run

# Other
sudo pacman -S bash-completion          # Provides tab completion for Bash commands and options
sudo pacman -S mousepad                 # Xfce's default text editor
sudo pacman -S rofi                     # Fast and flexible tool for application launching and searching

# Multimedia
# sudo pacman -S galculator              # Scientific calculator with advanced mathematical functions

# Office docs
# sudo pacman -S libreoffice-still       # Full-featured office suite for creating and editing documents

# System info tools
sudo pacman -S neofetch                 # Displays system information in a stylish format

    # Detailed hardware information
    # sudo pacman -S hwinfo                   # Provides comprehensive overview of system hardware components and their attributes
      
    # Detailed CPU information
    # sudo pacman -S lscpu                    # Displays detailed information about the CPU architecture, frequency, and cache
      
    # Sensor information and monitoring
    # sudo pacman -S lm-sensors               # Enables monitoring of CPU temperatures, fan speeds, and other hardware sensors
    # sudo pacman -S sensors                  # Reads and displays sensor data collected by lm-sensors
      
    # Hard disk information and health
    # sudo pacman -S smartmontools            # Provides hard disk health and performance information
    # sudo pacman -S hdparm                   # Allows querying and modifying hard disk parameters
      
    # Network information and connectivity
    # sudo pacman -S ip                       # Command-line utility for network interface management and information
    # sudo pacman -S net-tools                # Collection of essential network utilities (ping, traceroute, etc.)
      
    # System resources and process monitoring
    # sudo pacman -S htop                     # Interactive text-based process viewer with sorting and filtering
    # sudo pacman -S atop                     # Monitors and logs system resource usage over time
    # sudo pacman -S glances                  # Modern curses-based tool for monitoring CPU, memory, disk, and network usage
      
    # Other useful tools
    # sudo pacman -S inxi                     # Provides various system information in a concise format
    # sudo pacman -S screenfetch              # Displays system information along with a customizable ASCII logo
    # sudo pacman -S btop                     # Interactive process viewer with a graphical interface



# System Management
# sudo pacman -S zram-generator           # Tool for creating and managing zram devices (compressed RAM used as swap space)

# Sync tools
sudo pacman -S grsync                   # Gui tool for rsync (installs rsync too)
# sudo pacman -S rsync                    # tool for rsyncing files

# Other other
# sudo pacman -S baobab                   # Disk usage analyzer for visualizing disk space usage
# sudo pacman -S bleachbit                # System cleaning tool for removing temporary files and caches
# sudo pacman -S catfish                  # Desktop search tool for finding files quickly
# sudo pacman -S firejail                 # Sandbox tool for safely running applications without affecting system configuration

# Application Manager
# sudo pacman -S flatpak                  # Application manager for installing and managing self-contained sandboxes 
                                          # with software regardless of system distribution.



# Consider removing packages you don't plan on using for a leaner system.
# Explore alternatives based on your specific needs and preferences.

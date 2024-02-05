#!/bin/bash

# File system
sudo pacman -S file-roller              # Archiving tool for creating and managing compressed files
sudo pacman -S gvfs                     # Virtual filesystem for accessing network resources and devices
sudo pacman -S gvfs-mtp                 # Extension for gvfs to automatically mount MTP devices (like phones)
sudo pacman -S thunar                   # Lightweight and fast file manager
sudo pacman -S thunar-archive-plugin    # Thunar plugin for handling archives
sudo pacman -S thunar-volman            # Thunar plugin for managing removable devices

# Internet
#sudo pacman -S chromium                 # Open-source web browser based on the Blink rendering engine        
#yay -S brave                            # I use brave, which is installed later from AUR.Open-source web browser based on the Blink rendering engine        
sudo pacman -S transmission-gtk         # BitTorrent client with a user-friendly GTK interface

# Media
sudo pacman -S guvcview                 # Tool for viewing and adjusting webcam settings
sudo pacman -S mpv                      # Versatile media player with support for various formats
sudo pacman -S ristretto                # Simple and fast image viewer
sudo pacman -S scrot                    # Command-line screenshot tool for capturing and saving images
#sudo pacman -S mtpaint                 # Simple and lightweight graphical paint program
#sudo pacman -S peek                    # Tool for recording short screencasts as animated GIFs

# Tools
#sudo pacman -S rnote                    # Feature-rich and visually appealing text editor
#sudo pacman -S gpick                    # Advanced color picker tool for selecting and manipulating colors
#sudo pacman -S gsimplecal               # Simple calendar application for basic date management
#sudo pacman -S firejail                 # Sandbox tool for safely running applications without affecting system configuration

# Other
sudo pacman -S bash-completion          # Provides tab completion for Bash commands and options
sudo pacman -S mousepad                 # Xfce's default text editor
sudo pacman -S rofi                     # Fast and flexible tool for application launching and searching

# Multimedia
#sudo pacman -S galculator               # Scientific calculator with advanced mathematical functions

# Office docs
#sudo pacman -S libreoffice-still        # Full-featured office suite for creating and editing documents

# System info tools
sudo pacman -S neofetch                 # Displays system information in a stylish format
sudo pacman -S vdpauinfo                # Provides information about VDPAU capabilities (video acceleration)

# System Management
#sudo pacman -S zram-generator # Tool for creating and managing zram devices (compressed RAM used as swap space)

# Other other
#sudo pacman -S baobab                   # Disk usage analyzer for visualizing disk space usage
#sudo pacman -S bleachbit                # System cleaning tool for removing temporary files and caches
#sudo pacman -S catfish                  # Desktop search tool for finding files quickly
#sudo pacman -S firejail                 # Sandbox tool for safely running applications without affecting system configuration

# Application Manager
#sudo pacman -S flatpak                  # Application manager for installing and managing self-contained sandboxes 
                                         # with software regardless of system distribution.



# Consider removing packages you don't plan on using for a leaner system.
# Explore alternatives based on your specific needs and preferences.

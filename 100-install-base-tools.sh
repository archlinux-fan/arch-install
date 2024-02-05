#!/bin/bash

# File system
pacman -S file-roller              # Archiving tool for creating and managing compressed files
pacman -S gvfs                     # Virtual filesystem for accessing network resources and devices
pacman -S gvfs-mtp                 # Extension for gvfs to automatically mount MTP devices (like phones)
pacman -S thunar                   # Lightweight and fast file manager
pacman -S thunar-archive-plugin    # Thunar plugin for handling archives
pacman -S thunar-volman            # Thunar plugin for managing removable devices

# Internet
#pacman -S chromium                 # Open-source web browser based on the Blink rendering engine        
#yay -S brave                       # I use brave, which is installed later from AUR.Open-source web browser based on the Blink rendering engine        
pacman -S transmission-gtk         # BitTorrent client with a user-friendly GTK interface

# Media
pacman -S guvcview                 # Tool for viewing and adjusting webcam settings
pacman -S mpv                      # Versatile media player with support for various formats
pacman -S ristretto                # Simple and fast image viewer
pacman -S scrot                    # Command-line screenshot tool for capturing and saving images
#pacman -S mtpaint                 # Simple and lightweight graphical paint program
#pacman -S peek                    # Tool for recording short screencasts as animated GIFs

# Tools
#pacman -S rnote                    # Feature-rich and visually appealing text editor
#pacman -S gpick                    # Advanced color picker tool for selecting and manipulating colors
#pacman -S gsimplecal               # Simple calendar application for basic date management
#pacman -S firejail                 # Sandbox tool for safely running applications without affecting system configuration

# Other
pacman -S bash-completion          # Provides tab completion for Bash commands and options
pacman -S mousepad                 # Xfce's default text editor
pacman -S rofi                     # Fast and flexible tool for application launching and searching

# Multimedia
#pacman -S galculator               # Scientific calculator with advanced mathematical functions

# Office docs
#pacman -S libreoffice-still        # Full-featured office suite for creating and editing documents

# System info tools
pacman -S neofetch                 # Displays system information in a stylish format
pacman -S vdpauinfo                # Provides information about VDPAU capabilities (video acceleration)

# System Management
#pacman -S zram-generator # Tool for creating and managing zram devices (compressed RAM used as swap space)

# Other other
#pacman -S baobab                   # Disk usage analyzer for visualizing disk space usage
#pacman -S bleachbit                # System cleaning tool for removing temporary files and caches
#pacman -S catfish                  # Desktop search tool for finding files quickly
#pacman -S firejail                 # Sandbox tool for safely running applications without affecting system configuration



# Consider removing packages you don't plan on using for a leaner system.
# Explore alternatives based on your specific needs and preferences.

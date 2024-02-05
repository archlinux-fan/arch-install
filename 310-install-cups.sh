#!/bin/bash

# network and printer automatic discovery
# Avahi provides local hostname resolution using a "hostname.local" naming scheme. To enable it, install the nss-mdns package and start/enable avahi-daemon.service.
# Then, edit the file /etc/nsswitch.conf and change the hosts line to include mdns_minimal [NOTFOUND=return] before resolve and dns:
# hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns



# printer
# printer needs ghostscript (.pdf stuff) to print, cause it receives what to print in .pdf format
pacman -S cups ghostscript
systemctl enable cups.service



# Printing system components

# Core printing system
sudo pacman -S cups                      # Common Unix Printing System (CUPS) for printing management
# sudo pacman -S cups-pdf                  # PDF printing backend for CUPS
sudo pacman -S ghostscript               # PostScript interpreter for generating PDF and other formats
# sudo pacman -S gsfonts                   # Collection of PostScript fonts for proper rendering
# sudo pacman -S gutenprint                # Gutenprint printer driver backend for CUPS
# sudo pacman -S gtk3-print-backends       # GTK3 interface for various printing backends
# sudo pacman -S libcups                   # CUPS libraries for printing system functionality
# sudo pacman -S system-config-printer     # System configuration tool for managing printers

# Scanner support
# sudo pacman -S sane                      # Scanner Access Now Easy (SANE) for scanner access
# sudo pacman -S simple-scan               # Simple graphical scanner application

# Enable and start the CUPS service
sudo systemctl enable --now cups.service      # Enable and start the CUPS printing service

# Nework printers
# Avahi and nss-mdns can be helpful for setting up printers in Arch Linux alongside CUPS, but they aren't strictly necessary depending on your specific setup.
# Can be removed later once I think, but not sure 
sudo pacman -S avahi
sudo pacman -S nss-mdns

systemctl enable avahi-daemon

# click/enable option mdns in firewall GUI config "services" option - for printer to work
# better yet, change default zone form public to home, which has mdns enabled by default

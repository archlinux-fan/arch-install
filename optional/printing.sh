#!/bin/bash
# Printing with CUPS, driverless (IPP Everywhere): almost every network printer
# made since ~2015 prints without a driver from the vendor.

# CUPS is the print system. cups.socket starts it only when something prints,
# so it doesn't run all the time. Web interface: http://localhost:631
sudo pacman -S --needed cups && sudo systemctl enable --now cups.socket

# Avahi + nss-mdns find printers on the network by themselves and resolve
# names like printer.local. You don't need them if your printer has a fixed IP
# (a DHCP reservation in your router), and mDNS also needs the "mdns" service
# allowed in firewalld. If you install nss-mdns, add "mdns_minimal [NOTFOUND=return]"
# before "resolve" on the hosts: line in /etc/nsswitch.conf.
sudo pacman -S --needed avahi && sudo systemctl enable --now avahi-daemon
sudo pacman -S --needed nss-mdns

# Ghostscript turns pages into images for printers that can't read PDF, which is
# most home printers. CUPS picks its gstoraster filter for that; without
# ghostscript the job stops with "gstoraster filter failed".
sudo pacman -S --needed ghostscript

# Add a network printer by its IP. "-m everywhere" asks the printer itself what it can do.
read -rp "Printer IP (Enter to skip): " ip
if [ -n "$ip" ]; then
    read -rp "Printer name (no spaces, e.g. office): " name
    sudo lpadmin -p "$name" -E -v "ipp://$ip/ipp/print" -m everywhere
    # Print a test page with: lp -d <name> /usr/share/cups/data/testprint
fi

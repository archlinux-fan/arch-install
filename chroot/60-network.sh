#!/bin/bash
# Network and firewall.

# NetworkManager connects to Wi-Fi and Ethernet and reconnects by itself.
# After the first boot connect with: nmtui (menu) or nmcli device wifi connect "<name>" --ask
pacman -S --needed networkmanager && systemctl enable NetworkManager

# Each country has its own Wi-Fi rules: allowed channels and transmit power.
# Without a country set, the card uses the safest worldwide minimum:
# fewer channels, lower power, shorter range. Check later with: iw reg get
pacman -S --needed wireless-regdb
[ -z "$wifi_country" ] && read -rp "Wi-Fi country code (e.g. DE, Enter to skip): " wifi_country
[ -n "$wifi_country" ] && sed -i "s/^#\(WIRELESS_REGDOM=\"$wifi_country\"\)/\1/" /etc/conf.d/wireless-regdom

# iw shows and sets Wi-Fi details (iw reg get, iw dev wlan0 link).
pacman -S --needed iw

# firewalld blocks incoming connections you didn't allow.
# Each network gets a zone; "public" is the default and the strictest one.
# Allow a service with: firewall-cmd --permanent --zone=home --add-service=<name>
# Put your home Wi-Fi in the home zone with: nmcli connection modify "<name>" connection.zone home
pacman -S --needed firewalld && systemctl enable firewalld
# Nobody needs to log in to a desktop over SSH from a public network.
firewall-offline-cmd --zone=public --remove-service=ssh

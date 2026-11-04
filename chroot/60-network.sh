#!/bin/bash
# Network and firewall.

# NetworkManager connects to Wi-Fi and Ethernet and reconnects by itself.
# After the first boot connect with: nmtui (menu) or nmcli device wifi connect "<name>" --ask
pacman -S --needed networkmanager && systemctl enable NetworkManager

# firewalld blocks incoming connections you didn't allow.
# Each network gets a zone; "public" is the default and the strictest one.
# Allow a service with: firewall-cmd --permanent --zone=home --add-service=<name>
# Put your home Wi-Fi in the home zone with: nmcli connection modify "<name>" connection.zone home
pacman -S --needed firewalld && systemctl enable firewalld
# Nobody needs to log in to a desktop over SSH from a public network.
firewall-offline-cmd --zone=public --remove-service=ssh

# Not installed by default:
# Each country has its own Wi-Fi rules: allowed channels and transmit power.
# Newer Intel cards set them from their own firmware. Other cards (Atheros, Realtek,
# MediaTek ...) need this database and your country, otherwise they use the
# safest worldwide minimum: fewer channels, lower power, shorter range.
# Check your card with: lspci -k | grep -A3 -i network
# pacman -S --needed wireless-regdb
# [ -z "$wifi_country" ] && read -rp "Wi-Fi country code (e.g. GB, Enter to skip): " wifi_country
# [ -n "$wifi_country" ] && sed -i "s/^#\(WIRELESS_REGDOM=\"$wifi_country\"\)/\1/" /etc/conf.d/wireless-regdom
# iw shows Wi-Fi details: the country in use (iw reg get), signal and speed
# (iw dev wlan0 link). Only for checking; NetworkManager doesn't need it.
# pacman -S --needed iw

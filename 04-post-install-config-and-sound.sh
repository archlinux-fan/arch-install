#!/bin/bash

# sound
pacman -S pipewire pipewire-pulse wireplumber

# Firewall
pacman -S firewalld 
systemctl enable firewalld

# mirorrs automatic sorting 
pacman -S reflector
systemctl enable reflector.timer

# trim SSD drive
systemctl enable fstrim.timer

# network-manager-applet dialog wpa_supplicant avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset  flatpak sof-firmware nss-mdns acpid terminus-font

# systemctl enable sshd
# systemctl enable acpid 
# systemctl enable tlp # You can comment this command out if you didn't install tlp, see above


#!/bin/bash
#set -e
##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################

# Install grub and fix boot (os-prober rabiš če imaš še windows particijo)
sudo pacman -S grub efibootmgr dosfstools mtools base-devel

# Run grub install
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

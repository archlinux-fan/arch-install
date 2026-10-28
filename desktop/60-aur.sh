#!/bin/bash
# AUR: packages built from recipes (PKGBUILDs) written by users, not by Arch.
# Anyone can upload one, so read the PKGBUILD before you build it.
# Use it only for what the official repos don't have.

# base-devel has the compilers and makepkg, needed to build any AUR package.
sudo pacman -S --needed base-devel

# yay builds and updates AUR packages; yay-bin is the prebuilt version.
# After this, yay -Syu updates official and AUR packages together.
git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
(cd /tmp/yay-bin && makepkg -si)
rm -rf /tmp/yay-bin

# Brave Origin: Brave without Rewards, Wallet, VPN and AI. Not in the official repos.
yay -S --needed brave-origin-bin
# Regular Brave, only if you need its private windows with Tor (Brave Origin has no Tor).
# yay -S --needed brave-bin

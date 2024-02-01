#!/bin/bash

git clone https://aur.archlinux.org/yay.git

# Once done, switch to the cloned directory:
cd yay

# Build it. Follow instructions
makepkg -si

# You can test it's version
yay --version

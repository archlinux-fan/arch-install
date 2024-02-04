#!/bin/bash
#set -e
##################################################################################################################
# I got the ideas from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################


# Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed UTF-8 locales. Or just add them at the bottom of the file (It's easier to find anyway):
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "sl_SI.UTF-8 UTF-8" >> /etc/locale.gen

# Generate the locales by running:
locale-gen

# If you set the console keyboard layout, make the changes persistent in /etc/vconsole.conf and generates /etc/X11/xorg.conf.d/00-keyboard.conf
sudo localectl set-keymap slovene

# Create the /etc/locale.conf file, and set the LANG variable accordingly. Select prefered languages:
sudo localectl set-locale LANG=en_US.UTF-8

echo
tput setaf 3
echo "################################################################"
echo "Do you want add stuff for slovenian date, measurmenets (C), time format,...?"
echo "Answer with Y/y or N/n"
echo "################################################################"
tput sgr0
echo

read response

if [[ "$response" == [yY] ]]; then
    echo "LC_CTYPE=sl_SI.UTF-8
    LC_NUMERIC=sl_SI.UTF-8
    LC_TIME=sl_SI.UTF-8
    LC_COLLATE=sl_SI.UTF-8
    LC_MONETARY=sl_SI.UTF-8
    LC_MESSAGES=en_US.UTF-8
    LC_PAPER=sl_SI.UTF-8
    LC_NAME=sl_SI.UTF-8
    LC_ADDRESS=sl_SI.UTF-8
    LC_TELEPHONE=sl_SI.UTF-8
    LC_MEASUREMENT=sl_SI.UTF-8
    LC_IDENTIFICATION=sl_SI.UTF-8
    LC_ALL=" >> /etc/locale.conf
fi


# Set the font persistent in /etc/vconsole.conf
echo "FONT=lat2-16" >> /etc/vconsole.conf



echo
tput setaf 2
echo "################################################################"
echo "################### Done"
echo "################################################################"
tput sgr0
echo

echo
tput setaf 2
echo "################################################################"
echo "################### rebooting now after 5 seconds"
echo "Press CTRL +C to stop script"
echo "################################################################"
tput sgr0
echo

sleep 5

sudo reboot

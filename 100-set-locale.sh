#!/bin/bash
#set -e
##################################################################################################################
# I got the ideas from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



echo
tput setaf 2
echo "########################################### Choose locales ###########################################"; tput sgr0; tput setaf 3
echo "#"
echo "# Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed UTF-8 locales"
echo "# Or just add them at the bottom of the file (It's easier to find anyway):"
echo "######################################################################################################"
tput sgr0; 
echo

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "sl_SI.UTF-8 UTF-8" >> /etc/locale.gen



echo
tput setaf 2
echo "######################################### Generate the locales ###########################################"; tput sgr0; tput setaf 3
echo "#"
echo "# Generate locales that were added or uncommented in /etc/locale.gen in the previous step"
echo "# by running: locale-gen"
echo "######################################################################################################"
tput sgr0; 
echo

locale-gen



echo
tput setaf 2
echo "################################# Set the console keyboard layout ####################################"; tput sgr0; tput setaf 3
echo "#"
echo "# If you set the console keyboard layout, make the changes persistent in file /etc/vconsole.conf"
echo "# It generates file /etc/X11/xorg.conf.d/00-keyboard.conf too"
echo "# If you don't know which one you need use the 'localectl list-keymaps' command"
echo "######################################################################################################"
tput sgr0
echo

localectl set-keymap slovene



echo
tput setaf 2
echo "############################################ Set locales #############################################"; tput sgr0; tput setaf 3
echo "#"
echo "# Create the /etc/locale.conf file, and set the LANG variable accordingly"
echo "# Select prefered languages: (It will add LANG=en_US.UTF-8 by default)"
echo "######################################################################################################"
tput sgr0
echo

sudo localectl set-locale LANG=en_US.UTF-8



echo
tput setaf 3
echo "################################################################"
echo "Do you want add stuff for slovenian date, measurmenets (C), time format,...?"
echo "Answer with Y/y or N/n"
echo "################################################################"
tput sgr0
echo


echo
tput setaf 2
echo "######################################### Add slovenian stuff ########################################"; tput sgr0; tput setaf 3
echo "#"
echo "Do you want add stuff for slovenian date, measurmenets (C), time format,...?"
echo "Confirm with the 'y', 'Y', or just the Enter key"
echo "######################################################################################################"
tput sgr0
echo

read response
if [[ "$response" == [yY] || -z "$response" ]]; then
    # Code to execute if the response is either 'y', 'Y', or just the Enter key
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



echo
tput setaf 2
echo "############################################ Set the fonts ###########################################"; tput sgr0; tput setaf 3
echo "#"
echo "Set the font persistent in /etc/vconsole.conf. All available fonts are located at: ls /usr/share/kbd/consolefonts/"
echo "If you don't know which one you to use the 'ls /usr/share/kbd/consolefonts/' command"
echo "For Slovenians it's 'lat2-16'"
echo "######################################################################################################"
tput sgr0
echo

echo "FONT=lat2-16" >> /etc/vconsole.conf



echo
tput setab 2
echo "######################################### Locales are all set ########################################";
tput sgr0
echo



echo
tput setab 1
echo "###################################### Rebooting now in 5 seconds #####################################"; tput sgr0; tput setaf 2
echo "#"; tput sgr0; tput setaf 1; tput bold
echo "Press CTRL +C to stop script"; tput sgr0; tput setaf 2
echo "######################################################################################################"
tput sgr0
echo

sleep 5

sudo reboot

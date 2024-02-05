#!/bin/bash
#set -e
##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################
clear

echo
tput setaf 2
echo "################################################################"
echo "####################### Set the time : #########################"
echo "################################################################"
tput sgr0
echo


# Run time syncronization
timedatectl set-ntp true
echo "Check the time settings"
echo
timedatectl-status
sleep 5

# Run hwclock to generate file /etc/adjtime
hwclock --systohc

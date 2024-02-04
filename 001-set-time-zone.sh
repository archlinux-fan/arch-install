#!/bin/bash
#set -e
##################################################################################################################
# I got the ideas from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



echo
tput setaf 2
echo "##################################### Set the time zone (link): ######################################"; tput sgr0; tput setaf 3
echo "#"
echo "# To find Region and city"
echo "# ls /usr/share/zoneinfo/REGION"
echo "# ls /usr/share/zoneinfo/REGION/CITY"
echo "# ls /usr/share/zoneinfo/Europe/Ljubljana"
echo "#"
echo "# Run timedatectl to generate file /etc/localtime"
echo "# the command above creates a symlink:"
echo "# ln -sf /usr/share/zoneinfo/Europe/Ljubljana /etc/localtime"
echo "######################################################################################################"
tput sgr0; 
echo


echo
tput setab 2
echo "Set the time zone?"
tput sgr0
echo "Confirm with the 'y', 'Y', or just the Enter key"
echo

read response
if [[ "$response" == [yY] || -z "$response" ]]; then
  # Code to execute if the response is either 'y', 'Y', or just the Enter key
  timedatectl set-timezone Europe/Ljubljana
fi



echo
tput setab 2
echo "######################################### Time zone is set ########################################";
tput sgr0
echo

sleep 5

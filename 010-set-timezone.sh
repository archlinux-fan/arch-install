#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



##################################################### Colors #####################################################
color_bg="tput setab 0"

color_comment_text="tput setaf 4"
color_comment_command="tput setaf 5"

color_input_text="tput setaf 6"

color_success_text="tput setaf 2"
##################################################################################################################

echo
$color_comment_text
printf "###################################   "; $color_bg; echo -n "  Set the time zone (link):  "; tput sgr0; $color_comment_text; echo "   ##################################"
echo "# To find Region and city"
printf "# "; $color_comment_command; echo "ls /usr/share/zoneinfo/REGION"; $color_comment_text
printf "# "; $color_comment_command; echo "ls /usr/share/zoneinfo/REGION/CITY"; $color_comment_text
printf "# "; $color_comment_command; echo "ls /usr/share/zoneinfo/Europe/Ljubljana"; $color_comment_text
echo "#"
echo "# Run timedatectl set-timezone to generate file /etc/localtime"
echo "# The command above creates a symlink:"
printf "# "; $color_comment_command; echo "ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime"; $color_comment_text
echo "########################################################################################################"
tput sgr0


timezone_default="Europe/Ljubljana"


while true; do
		echo
    read -p "Enter your timezone or hit enter for [$timezone_default]: " timezone_new
    tput sgr0
    		
		timezone_new=${timezone_new:-$timezone_default}  # Use default if user enters nothing
    
		echo
		echo "[$(whoami)@$HOSTNAME $(basename "${PWD}")]$ timedatectl set-timezone $timezone_new"
		tput sgr0

		timedatectl set-timezone $timezone_new
		
    if [[ $? -eq 0 ]]; then
        break  # Exit the loop if commands were successful
    else
        echo "Try again."
				echo
    fi
done

echo
$color_success_text
printf "Time zone is set to: "; $color_bg; echo " $timezone_new "; tput sgr0
echo

sleep 2

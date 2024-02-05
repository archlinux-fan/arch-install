#!/bin/bash

# In Bash, set -e is a powerful option that controls how the script handles errors during execution. Let's break it down:
# 	set: This is a built-in command in Bash used to manage shell options and variables.
# 	-e: This is a flag passed to the set command, representing the specific option you want to modify. In this case, -e stands for "exit on error."
set -e 

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################


sh 010-set-timezone*
sh 011-set-time*
	
sh 020-set-locale*

sh 030-hosts*

sh 040-user-group*

sh 050-grub*

# linux-headers - you only need the headers in the case you want to build custom kernel modules and/or want to use DKMS packages
# sudo pacman -S linux-headers

sh 060-network*

sh 070-bluetooth*

sh 080-sound*




echo "All chosen scripts have finished running."












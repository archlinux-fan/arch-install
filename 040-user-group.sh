#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



# Users and pass
# Set root pass
echo "Chose the password for the root user: (single word, small letters)"
read rootpass
echo root:$rootpass | chpasswd # chpasswd is a command to create pass

# Add user and add it to groups
echo "Chose your username: (one word, small letters)"
read username
echo "Chose the password for the $username user: (single word, small letters)"
read userpass
useradd -m $username
echo $username:$userpass | chpasswd
# usermod -G wheel -a $username - ne rabiš dodat userja v wheel grupo, ker imaš to spodaj, in mu daš itak vse pravice
echo "$username ALL=(ALL) ALL" >> /etc/sudoers.d/$username
echo "Defaults passwd_timeout=10" >> /etc/sudoers.d/$username      # Disable password prompt timeout
echo "Defaults timestamp_timeout=10" >> /etc/sudoers.d/$username      # Reduce the number of times you have to type a password
#Defaults insults                               # Upon entering an incorrect password this will replace Sorry, try again. message with humoro>
#Defaults pwfeedback                             # visual feedback when you input a password

# if it didn't work then uncomment #%wheel ALL=(ALL:ALL) ALL in sudoers file with"
# sudo nano /etc/sudoers or
# EDITOR=nano visudo"

echo "Add the below line which makes it so that you don't have to reinsert password in each terminal a user uses sudo in"
echo "I am not sure if it's working though"
echo "Defaults passwd_timeout=30			# Disable password prompt timeout" >> /etc/sudoers.d/$username
echo "# Defaults timestamp_type=global			# Disable per-terminal sudo" >> /etc/sudoers.d/$username
echo "Defaults timestamp_timeout=30			# Reduce the number of times you have to type a password" >> /etc/sudoers.d/$username
echo



# Consider using sudo -b. 
# This starts a background process with root privileges that lasts until you close the terminal window.
# Use this with caution as the elevated access persists even after you close the current shell session within the window.
# Remember to exit the background process when finished to revoke root privileges.

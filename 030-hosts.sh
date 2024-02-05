#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################



# Hostname settings
echo "Chose the hostname for your computer: (one word, small letters)"
read hostname
echo $hostname >> /etc/hostname

# Hosts settings
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1        localhost" >> /etc/hosts
echo "127.0.1.1  $hostname.localdomain $hostname" >> /etc/hosts

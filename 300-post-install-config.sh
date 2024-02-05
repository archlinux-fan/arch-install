#!/bin/bash

# Firewall
pacman -S firewalld 

# enable the firewalld service
systemctl enable firewalld

# mirorrs automatic sorting 
pacman -S reflector

# enable the reflector timer to run weekly
systemctl enable reflector.timer

# trim SSD drive
# enable the fstrim timer to trim SSD drive weekly
systemctl enable fstrim.timer

# systemctl enable sshd
# systemctl enable acpid 
# systemctl enable tlp # You can comment this command out if you didn't install tlp, see above


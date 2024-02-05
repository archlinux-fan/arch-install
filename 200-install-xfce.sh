#!/bin/bash

# login manager
pacman -S lightdm 
pacman -S lightdm-gtk-greeter
pacman -S lightdm-gtk-greeter-settings

# enable the lightdm service
systemctl enable lightdm

# package is a GTK 3 front-end which works under Xorg environments with a systray
pacman -S network-manager-applet

# package is needed to set sound levels in XFCE panel like xfce4-pulseaudio-plugin
pacman -S pavucontrol

# death icon to kill apps with a mouse
pacman -S xorg-xkill

# theme - morda ne rabim, ker staknem nordic z yay potem
# pacman -S arc-gtk-theme arc-icon-theme 

# icons
pacman -S papirus-icon-theme

# install xfce and stuff
pacman -S xfce4-battery-plugin
pacman -S xfce4-clipman-plugin 
pacman -S xfce4-notifyd 
pacman -S xfce4-panel
pacman -S xfce4-pulseaudio-plugin 
pacman -S xfce4-screensaver
pacman -S xfce4-screenshooter 
pacman -S xfce4-session 
pacman -S xfce4-settings 
pacman -S xfce4-taskmanager 
pacman -S xfce4-terminal 
pacman -S xfce4-time-out-plugin 
pacman -S xfce4-weather-plugin 
pacman -S xfdesktop 
pacman -S xfwm4 
pacman -S xfwm4-themes


# xfce4-power-manager - for laptop battery, za desktop tudi ampak brez veze. Za diske dat v sleep ipd
# pacman -S xfce4-power-manager


printf "reboot now to try lightdm"

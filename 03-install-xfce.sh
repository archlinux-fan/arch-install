#!/bin/bash

# login manager
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm

pacman -S network-manager-applet
pacman -S pavucontrol # rabiš ga, da štelaš sound, ko klikneš v panelu na xfce4-pulseaudio-plugin
pacman -S xorg-xkill

# theme - morda ne rabim, ker staknem nordic z yay potem
# pacman -S arc-gtk-theme arc-icon-theme 

# icons
pacman -S papirus-icon-theme

# install xfce
pacman -S xfce4-battery-plugin xfce4-clipman-plugin xfce4-notifyd xfce4-panel xfce4-pulseaudio-plugin xfce4-screensaver xfce4-screenshooter xfce4-session xfce4-settings xfce4-taskmanager xfce4-terminal xfce4-time-out-plugin xfce4-weather-plugin xfdesktop xfwm4 xfwm4-themes

# xfce4-power-manager - for laptop battery, za desktop tudi ampak brez veze. Za diske dat v sleep ipd
# pacman -S xfce4-power-manager

printf "reboot now to try lightdm"

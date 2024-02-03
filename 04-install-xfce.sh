#!/bin/bash

# login manager
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm



pacman -S network-manager-applet
pacman -S pavucontrol # rabiš ga, da štelaš sound, ko klikneš v panelu na xfce4-pulseaudio-plugin


# icons and theme

pacman -S arc-gtk-theme arc-icon-theme papirus-icon-theme

pacman -S xfce4-battery-plugin xfce4-clipman-plugin xfce4-notifyd xfce4-panel xfce4-pulseaudio-plugin xfce4-screensaver xfce4-screenshooter xfce4-session xfce4-settings xfce4-taskmanager xfce4-terminal xfce4-time-out-plugin xfce4-weather-plugin xfdesktop xfwm4 xfwm4-themes

# xfce4-power-manager - for laptop battery, za desktop tudi ampak brez veze. Za diske dat v sleep ipd
# pacman -S xfce4-power-manager




printf " 
reboot now
"

# spodnji in xorg.xinit se že gor inštalirata
# pacman -S xorg-server

: <<'END_COMMENT'

xorg-bdftopcf
xorg-docs
xorg-font-util
xorg-fonts-100dpi
xorg-fonts-75dpi
xorg-fonts-encodings
xorg-iceauth
xorg-mkfontscale
xorg-server
xorg-server-common
xorg-server-devel
xorg-server-xephyr
xorg-server-xnest
xorg-server-xvfb
xorg-sessreg
xorg-setxkbmap
xorg-smproxy
xorg-x11perf
xorg-xbacklight
xorg-xcmsdb
xorg-xcursorgen
xorg-xdpyinfo
xorg-xdriinfo
xorg-xev
xorg-xgamma
xorg-xhost
xorg-xinit
xorg-xinput
xorg-xkbcomp
xorg-xkbevd
xorg-xkbutils
xorg-xkill
xorg-xlsatoms
xorg-xlsclients
xorg-xpr
xorg-xrandr
xorg-xrefresh
xorg-xset
xorg-xsetroot
xorg-xvinfo
xorg-xwayland
xorg-xwd
xorg-xwininfo
xorg-xwud

END_COMMENT

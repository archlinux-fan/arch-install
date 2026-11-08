#!/bin/bash
# mango desktop: the compositor and the small tools around it.
# mango only draws and arranges windows; bar, notifications, launcher, lock screen
# and wallpaper are separate programs, started from ~/.config/mango.

# The compositor. ~/.bash_profile from the dotfiles starts it when you log in on
# the first console (zsh: ~/.config/zsh/.zprofile); without them type: mango
sudo pacman -S --needed mangowm
# Portal: lets apps share the screen and take screenshots through mango.
# File open/save windows come from xdg-desktop-portal-gtk, installed with GTK 4.
sudo pacman -S --needed xdg-desktop-portal-wlr
# Polkit agent: the password window when a GUI app needs admin rights
# (firewall-config, mounting a disk). Without it such actions silently fail.
sudo pacman -S --needed polkit-gnome
# Idle daemon: dims, locks and turns off the screen after inactivity.
sudo pacman -S --needed swayidle
# Lock screen.
sudo pacman -S --needed swaylock
# Or hyprlock, the Hyprland lock screen: also works on mango, with blur and
# more layout options. Needs its own config and changes where it is started.
# sudo pacman -S --needed hyprlock
# Wallpaper.
sudo pacman -S --needed swaybg

# Screenshots: slurp selects a region or window, grim captures it,
# satty draws arrows and text on it. grim + slurp also pick a color.
sudo pacman -S --needed grim
sudo pacman -S --needed slurp
sudo pacman -S --needed satty
# Or hyprpicker as the color picker, with a zoom lens: click anywhere to copy the color.
# sudo pacman -S --needed hyprpicker

# Clipboard: wl-clipboard gives wl-copy/wl-paste, wl-clip-persist keeps
# copied text after the app you copied from closes.
sudo pacman -S --needed wl-clipboard
sudo pacman -S --needed wl-clip-persist

# Status bar.
sudo pacman -S --needed waybar
# Notifications.
sudo pacman -S --needed mako
# App launcher and menus.
sudo pacman -S --needed fuzzel
# Wi-Fi icon and menu in the bar (nm-applet).
sudo pacman -S --needed network-manager-applet

# Fonts: Noto covers almost every language, noto-fonts-emoji adds color emoji,
# Font Awesome provides the icons in waybar.
sudo pacman -S --needed noto-fonts
sudo pacman -S --needed noto-fonts-emoji
sudo pacman -S --needed otf-font-awesome
sudo pacman -S --needed woff2-font-awesome
# Fallback icon theme, used when your icon theme lacks an icon.
sudo pacman -S --needed hicolor-icon-theme

# Not installed by default:
# Window to pick the GTK theme, icons, cursor and font. Not needed once they are set;
# gsettings does the same in the terminal (the arch-dots README has the commands).
# sudo pacman -S --needed nwg-look
# Clipboard history.
# sudo pacman -S --needed cliphist
# Graphical login screen. Not needed: log in on the console, mango starts from ~/.bash_profile.
# sudo pacman -S --needed sddm && sudo systemctl enable sddm
# Session manager that starts the compositor as a systemd unit; only for complex setups.
# sudo pacman -S --needed uwsm

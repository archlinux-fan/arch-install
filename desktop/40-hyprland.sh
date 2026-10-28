#!/bin/bash
# Hyprland desktop: the compositor and the small tools around it.
# Hyprland only draws windows; bar, notifications, launcher, lock screen and
# wallpaper are separate programs, started from ~/.config/hypr.

# The compositor. Start it from the TTY with: start-hyprland
sudo pacman -S --needed hyprland
# Portal: lets apps share the screen and open file pickers through Hyprland.
sudo pacman -S --needed xdg-desktop-portal-hyprland
# Polkit agent: the password window when a GUI app needs admin rights
# (firewall-config, mounting a disk). Without it such actions silently fail.
sudo pacman -S --needed hyprpolkitagent
# Idle daemon: dims, locks and turns off the screen after inactivity.
sudo pacman -S --needed hypridle
# Lock screen.
sudo pacman -S --needed hyprlock
# Wallpaper.
sudo pacman -S --needed hyprpaper
# Color picker: click anywhere on screen to copy the color.
sudo pacman -S --needed hyprpicker

# Screenshots: hyprshot selects a window or region, using grim (capture)
# and slurp (select). satty draws arrows and text on the screenshot.
sudo pacman -S --needed hyprshot
sudo pacman -S --needed grim
sudo pacman -S --needed slurp
sudo pacman -S --needed satty

# Clipboard: wl-clipboard gives wl-copy/wl-paste, wl-clip-persist keeps
# copied text after the app you copied from closes.
sudo pacman -S --needed wl-clipboard
sudo pacman -S --needed wl-clip-persist

# Status bar.
sudo pacman -S --needed waybar
# Notifications.
sudo pacman -S --needed mako
# App launcher and menus.
sudo pacman -S --needed rofi
# Wi-Fi icon and menu in the bar (nm-applet).
sudo pacman -S --needed network-manager-applet
# Sets the GTK theme, icons, cursor and font.
sudo pacman -S --needed nwg-look

# Fonts: Noto covers almost every language, noto-fonts-emoji adds color emoji,
# Font Awesome provides the icons in waybar.
sudo pacman -S --needed noto-fonts
sudo pacman -S --needed noto-fonts-emoji
sudo pacman -S --needed otf-font-awesome
sudo pacman -S --needed woff2-font-awesome
# Fallback icon theme, used when your icon theme lacks an icon.
sudo pacman -S --needed hicolor-icon-theme

# Not installed by default:
# Clipboard history.
# sudo pacman -S --needed cliphist
# Graphical login screen. Not needed: log in on the TTY, Hyprland starts from ~/.zprofile.
# sudo pacman -S --needed sddm && sudo systemctl enable sddm
# Session manager that starts Hyprland as a systemd unit; only for complex setups.
# sudo pacman -S --needed uwsm

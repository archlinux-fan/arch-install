#!/bin/bash
# Dotfiles: your settings (Hyprland, waybar, themes, zsh ...) kept in a git repo.
# The repo mirrors your home folder; stow links every file into ~,
# so ~/.config/hypr/hyprland.lua points into ~/.dots and changes land in git.
# A private repo (ssh config, git name and e-mail, monitors) goes to ~/.private
# the same way. A file must live in only one of the two repos.
# --no-folding links files, not whole folders, so both repos can share a folder
# and programs never write their own files into your repos.

[ -z "$dots_url" ] && read -rp "Dotfiles repo URL (Enter to skip): " dots_url
[ -n "$dots_url" ] && [ ! -d ~/.dots ] && git clone "$dots_url" ~/.dots
[ -d ~/.dots ] && stow --no-folding -d ~/.dots -t ~ .

# private_dir in the settings file puts it somewhere else than ~/.private.
private_dir=${private_dir:-$HOME/.private}
[ -z "$private_url" ] && read -rp "Private repo URL (Enter to skip): " private_url
[ -n "$private_url" ] && [ ! -d "$private_dir" ] && git clone "$private_url" "$private_dir"
[ -d "$private_dir" ] && stow --no-folding -d "$private_dir" -t ~ .

# Autologin on the first console (TTY1). Your ~/.zprofile then starts Hyprland
# and hyprlock asks for the password. Makes sense with LUKS: you already typed a
# password at boot. Without LUKS anyone who turns on the computer gets your desktop
# until hyprlock is up, so prefer the normal TTY login there.
[ -z "$autologin" ] && read -rp "Log in automatically on TTY1? [y/N] " autologin
if [[ $autologin == [yY]* ]]; then
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
    sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\\\u' --noclear --autologin $USER %I \$TERM
EOF
fi

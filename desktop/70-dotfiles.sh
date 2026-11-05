#!/bin/bash
# Dotfiles: your settings (mango, waybar, themes, shell ...) kept in a git repo.
# The repo mirrors your home folder: its .config/mango/config.toml belongs in ~/.config/mango/.
# Enter takes arch-dots, the desktop in the pictures.
[ -z "$dots_url" ] && read -rp "Dotfiles repo URL (Enter = arch-dots, n = none): " dots_url
dots_url=${dots_url:-https://github.com/archlinux-fan/arch-dots}

# stow links every file of a repo into ~. Only for dots_link=y and a private repo,
# both set in the settings file; a first install doesn't need it.
[[ $dots_link == [yY]* || -n $private_url ]] && sudo pacman -S --needed stow

if [[ $dots_link == [yY]* ]]; then
    # Linked: ~/.config/mango/config.toml points into ~/.dots, so your changes land in git.
    # --no-folding links files, not whole folders, so two repos can share a folder.
    # Arch gives every new user a ~/.bash_profile; stow won't replace it, so an unchanged one goes.
    [ -d ~/.dots ] || git clone "$dots_url" ~/.dots
    cmp -s ~/.bash_profile /etc/skel/.bash_profile && rm ~/.bash_profile
    stow --no-folding -d ~/.dots -t ~ .
elif [[ $dots_url != [nN]* ]]; then
    # Copied once: plain files you can change freely. The repo's own files
    # (git, README, docs, screenshots) stay out of ~.
    # GLOBIGNORE also makes * include the hidden files.
    git clone --depth 1 "$dots_url" /tmp/dots
    (cd /tmp/dots && GLOBIGNORE='.git*:.stow-local-ignore:README*:docs:screenshots' && cp -r * ~)
    rm -rf /tmp/dots
fi

# GTK apps on Wayland take the theme, icons, cursor and font from gsettings,
# not from the dotfiles' settings.ini: copy them over once.
ini=~/.config/gtk-3.0/settings.ini
if [ -f "$ini" ]; then
    # settings.ini name (after gtk-) : gsettings name
    for p in theme-name:gtk-theme icon-theme-name:icon-theme cursor-theme-name:cursor-theme \
             cursor-theme-size:cursor-size font-name:font-name; do
        v=$(sed -n "s/^gtk-${p%:*}=//p" "$ini")
        [ -n "$v" ] && gsettings set org.gnome.desktop.interface "${p#*:}" "$v"
    done
    grep -q '^gtk-application-prefer-dark-theme=1' "$ini" && gsettings set org.gnome.desktop.interface color-scheme prefer-dark
fi

# Private repo (ssh config, git name and e-mail, monitors): only from the settings
# file, see docs/private-repo.md. Cloned to ~/.private or private_dir, then linked
# with stow. A file must live in only one of the two repos.
private_dir=${private_dir:-$HOME/.private}
[ -n "$private_url" ] && [ ! -d "$private_dir" ] && git clone "$private_url" "$private_dir"
[ -n "$private_url" ] && stow --no-folding -d "$private_dir" -t ~ .

# Autologin on the first console (TTY1). Your ~/.bash_profile then starts mango
# and swaylock asks for the password. Makes sense with LUKS: you already typed a
# password at boot. Without LUKS anyone who turns on the computer gets your desktop
# until swaylock is up, so prefer the normal TTY login there.
[ -z "$autologin" ] && read -rp "Log in automatically on TTY1? [y/N] " autologin
if [[ $autologin == [yY]* ]]; then
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
    sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\\\u' --noclear --autologin $USER %I \$TERM
EOF
fi

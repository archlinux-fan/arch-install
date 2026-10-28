#!/bin/bash
# Time zone, language and keyboard.
# timedatectl and localectl need a booted system, so inside the chroot
# we write their files directly.

# The time zone is a link from /etc/localtime to a file in /usr/share/zoneinfo.
# See what exists with: ls /usr/share/zoneinfo/Europe
[ -z "$timezone" ] && read -rp "Time zone (e.g. Europe/Berlin): " timezone
ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime

# Copy the system time to the hardware clock and create /etc/adjtime.
hwclock --systohc

# systemd-timesyncd keeps the clock right over the internet (NTP).
# It is part of systemd, so nothing to install. Installing a service never
# starts it: "enable" tells systemd to start it at every boot.
systemctl enable systemd-timesyncd

# Locales define language, date format, decimal comma, units, sorting.
# They must be uncommented in /etc/locale.gen and then generated.
# English messages are the most common choice, so en_US is always generated.
# Add more later by uncommenting lines in /etc/locale.gen and running locale-gen.
[ -z "$locale" ] && read -rp "Your locale for dates, numbers and units (e.g. de_DE, Enter = en_US): " locale
locale=${locale:-en_US}
sed -i "s/^#\(en_US.UTF-8 UTF-8\)/\1/; s/^#\($locale.UTF-8 UTF-8\)/\1/" /etc/locale.gen
locale-gen

# LANG sets everything to your locale, LC_MESSAGES keeps program messages in English.
printf 'LANG=%s.UTF-8\nLC_MESSAGES=en_US.UTF-8\n' "$locale" > /etc/locale.conf

# Console keyboard layout and font, used in the text console (TTY) and in the
# LUKS password prompt at boot, so your password is typed with the right layout.
# Layouts: ls /usr/share/kbd/keymaps/**/*.map.gz    Fonts: ls /usr/share/kbd/consolefonts
# lat2-16 covers Central European letters, LatArCyrHeb-16 covers most of Europe.
[ -z "$keymap" ] && read -rp "Console keymap (e.g. de, fr, Enter = us): " keymap
[ -z "$font" ] && read -rp "Console font (e.g. lat2-16, Enter = default): " font
printf 'KEYMAP=%s\n' "${keymap:-us}" > /etc/vconsole.conf
[ -n "$font" ] && printf 'FONT=%s\n' "$font" >> /etc/vconsole.conf

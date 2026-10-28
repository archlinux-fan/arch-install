#!/bin/bash
# Runs every script in a folder in order and asks before each one.
# Usage: ./run.sh chroot   [settings]   (as root, inside arch-chroot)
#        ./run.sh desktop  [settings]   (as your user, after the first boot)
# settings: optional file with your answers, see settings.example.

if [ -n "$2" ]; then
    set -a      # export every variable from the file to the scripts
    source "$2" || exit 1
    set +a
fi

cd "$(dirname "$0")/$1" || exit 1

for script in *.sh; do
    read -rp "Run $1/$script? [Y/n] " answer
    [[ $answer == [nN]* ]] && continue
    bash "$script"
done

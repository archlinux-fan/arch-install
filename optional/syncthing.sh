#!/bin/bash
# Syncthing syncs folders between your devices (phone, other computers)
# directly, without a cloud. Web interface: http://127.0.0.1:8384

# It runs as your user (systemctl --user), so it only sees your files.
sudo pacman -S --needed syncthing && systemctl --user enable --now syncthing

# Let other devices on your home network connect. Only the home zone, not public.
sudo firewall-cmd --permanent --zone=home --add-service=syncthing
sudo firewall-cmd --reload

# Tips for syncing only inside your home network:
# - Settings → Connections: turn off NAT traversal, Global Discovery and Relaying,
#   keep Local Discovery.
# - Photos from your phone: set the folder to "Receive Only" on the computer,
#   so deleting on the computer never deletes on the phone.
# - "Revert Local Changes" brings back everything you deleted locally; use with care.

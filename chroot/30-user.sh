#!/bin/bash
# Root password and your own user.

# With sudo you rarely log in as root, but systemd's emergency shell asks for
# this password when the system can't boot normally.
echo "Root password:"
passwd

# -m creates the home folder, -G wheel adds the user to the admin group.
[ -z "$username" ] && read -rp "Username (lowercase): " username
useradd -m -G wheel "$username"
echo "Password for $username:"
passwd "$username"

# sudo lets the wheel group run commands as root with their own password.
# A file in /etc/sudoers.d is safer than editing /etc/sudoers itself.
# Files are read in name order and the last matching rule wins. The number puts
# this one first, so a file of your own (e.g. named after you) can change its rules.
# Always edit these files with: visudo -f /etc/sudoers.d/10-wheel
echo '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers.d/10-wheel
chmod 440 /etc/sudoers.d/10-wheel

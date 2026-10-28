#!/bin/bash
# Boot loader: systemd-boot.
# It ships with systemd and installs into the EFI partition mounted at /boot,
# next to the kernels. It finds Windows by itself if EFI/Microsoft is on the same partition.
bootctl install

# Updates systemd-boot on /boot after every systemd upgrade.
systemctl enable systemd-boot-update.service

# The kernel needs to know where the root partition is.
# Plain disk: root=UUID=... points straight to it.
# LUKS: rd.luks.name=<UUID>=root tells the initramfs to ask for your password,
# unlock that partition and open it as /dev/mapper/root. No key is stored anywhere.
root_dev=$(findmnt -no SOURCE /)
if [[ $root_dev == /dev/mapper/* ]]; then
    luks_dev=$(cryptsetup status "$root_dev" | awk '/device:/ {print $2}')
    options="rd.luks.name=$(blkid -s UUID -o value "$luks_dev")=root root=/dev/mapper/root rw"
    # sd-encrypt is the initramfs step that asks for the password and unlocks the disk.
    sed -i '/^HOOKS=/s/block filesystems/block sd-encrypt filesystems/' /etc/mkinitcpio.conf
else
    options="root=UUID=$(blkid -s UUID -o value "$root_dev") rw"
fi

# Rebuild the initramfs: the small system that starts before your real root is mounted.
# The "microcode" hook already puts CPU microcode (amd-ucode / intel-ucode) inside it.
mkinitcpio -P

# Menu settings: seconds to wait, default entry, no editing of kernel options at boot.
printf 'default linux.conf\ntimeout 3\neditor no\n' > /boot/loader/loader.conf

# One menu entry per installed kernel (linux, and linux-lts if you installed it as a backup).
for kernel in linux linux-lts; do
    [ -f "/boot/vmlinuz-$kernel" ] || continue
    printf 'title   Arch Linux (%s)\nlinux   /vmlinuz-%s\ninitrd  /initramfs-%s.img\noptions %s\n' \
        "$kernel" "$kernel" "$kernel" "$options" > "/boot/loader/entries/$kernel.conf"
done

# Tips

[← Back](../README.md)

## Keeping it healthy

```bash
sudo pacman -Syu                    # update everything; yay -Syu also updates AUR packages
systemctl --failed                  # services that failed
journalctl -p 3 -b                  # errors since this boot
pacman -Qdtq                        # orphans: dependencies nothing needs any more
sudo pacman -Rns $(pacman -Qdtq)    # remove them
sudo pacman -Sc                     # clean the package cache
```

- Always update the whole system. Never `pacman -Sy <package>`: a half-updated system can break.
- Read [archlinux.org/news](https://archlinux.org/news/) before updating; it announces the rare manual steps.
- Pacman never overwrites a config file you changed. It saves the new one as `.pacnew` next to it; compare and merge.

## Network

```bash
nmtui                                         # menu for Wi-Fi and connections
nmcli device wifi list                        # networks in range
nmcli device wifi connect "Name" --ask        # connect, asks for the password
nmcli connection modify "Name" connection.zone home   # trust this network in the firewall
firewall-cmd --get-active-zones               # which zone each network is in
```

## When it doesn't boot

Pick the LTS kernel in the boot menu, if you installed it. If that fails too, boot the Arch ISO and repair from there:

```bash
cryptsetup open /dev/nvme0n1p2 root           # only with LUKS
mount /dev/mapper/root /mnt                   # or: mount /dev/nvme0n1p2 /mnt
mount /dev/nvme0n1p1 /mnt/boot
arch-chroot /mnt
pacman -Syu                                   # e.g. finish an interrupted update
mkinitcpio -P                                 # rebuild the initramfs
```

## Later, if you want

- **Unlock LUKS with the TPM chip** instead of a passphrase: `systemd-cryptenroll`. Convenient, but then anyone holding
  the computer gets to the login screen. [Wiki](https://wiki.archlinux.org/title/Systemd-cryptenroll)
- **Secure Boot** with your own keys: `sbctl`. [Wiki](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot)

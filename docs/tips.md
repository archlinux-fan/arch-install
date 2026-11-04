# Tips

[← Back](../README.md)

## Keeping it healthy

Arch updates all the time, in small steps. Update about once a week; with arch-dots, waybar shows how many updates wait.

```bash
sudo pacman -Syu                    # update everything; yay -Syu also updates AUR packages
systemctl --failed                  # background services that failed
journalctl -p 3 -b                  # errors since this boot
pacman -Qdtq                        # orphans: packages that were needed by something you removed
sudo pacman -Rns $(pacman -Qdtq)    # remove them
sudo pacman -Sc                     # delete old downloaded packages
```

- Always update the whole system. Never `pacman -Sy <package>`: a half-updated system can break.
- Read [archlinux.org/news](https://archlinux.org/news/) before updating; it announces the rare manual steps.
- Pacman never overwrites a settings file you changed. It saves the new one as `.pacnew` next to it;
  compare the two and copy over what you want.
- Reboot after a kernel (`linux`) update, so the new kernel is used.

## Network

```bash
nmtui                                         # menu for Wi-Fi and connections
nmcli device wifi list                        # networks in range
nmcli device wifi connect "Name" --ask        # connect, asks for the password
nmcli connection modify "Name" connection.zone home   # trust this network in the firewall
firewall-cmd --get-active-zones               # which zone each network is in
```

The firewall puts every network in a zone. `public` (the default) blocks everything coming in,
`home` also lets in a few things from your own network, like ssh and finding devices (mDNS).

## Finding help

- [Arch Wiki](https://wiki.archlinux.org): the best Linux documentation there is, for Arch and for every program.
- `man <command>` shows a command's manual (q quits), `<command> --help` a short version.
- Search for the exact error message, in quotes.

## When it doesn't boot

Pick the LTS kernel in the boot menu, if you installed it. If that fails too, boot the USB stick and repair from there.
Replace the partition names with yours (`lsblk`):

```bash
cryptsetup open /dev/nvme0n1p2 root           # only with LUKS
mount /dev/mapper/root /mnt                   # or without LUKS: mount /dev/nvme0n1p2 /mnt
mount /dev/nvme0n1p1 /mnt/boot
arch-chroot /mnt                              # step inside your system, like during the install
pacman -Syu                                   # e.g. finish an interrupted update
mkinitcpio -P                                 # rebuild the initramfs, the first small step of every boot
exit
reboot
```

## Later, if you want

- **Unlock LUKS with the TPM chip** instead of a passphrase: `systemd-cryptenroll`. Convenient, but then anyone holding
  the computer gets to the login screen. [Wiki](https://wiki.archlinux.org/title/Systemd-cryptenroll)
- **Secure Boot** with your own keys: `sbctl`. [Wiki](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot)

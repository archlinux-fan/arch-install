# Arch Linux + Hyprland

A minimal Arch Linux install with the Hyprland desktop, in small readable scripts.

- One package per line. Pacman asks `[Y/n]` for each one, so you install only what you want.
- A comment above every command explains what it is and why it's there.
- Optional disk encryption (LUKS2), optional dual boot with Windows.
- Only official packages, except one browser from the AUR.

![Hyprland desktop with the Nord theme](https://raw.githubusercontent.com/archlinux-fan/arch-dots/main/screenshots/fastfetch.png)

The desktop comes from [arch-dots](https://github.com/archlinux-fan/arch-dots), more screenshots there.

Read it as a website: [archlinux-fan.github.io/arch-install](https://archlinux-fan.github.io/arch-install/)

This page gets you from the Arch ISO to the scripts. More:
[how the scripts work](docs/scripts.md) · [tips](docs/tips.md) · [your own private repo](docs/private-repo.md)

Commands are for the Arch ISO, where you are root. Replace `nvme0n1p1`-style names with yours.

## Before you start

- UEFI computer. Turn **Secure Boot off** in the firmware settings ([later](docs/tips.md#later-if-you-want)).
- A USB stick (2 GB+) and internet.
- **Dual boot:** shrink the Windows partition in Windows (Disk Management → Shrink Volume), leave the space unallocated.
  If Windows uses BitLocker, save its recovery key first (Microsoft account → Devices, or `manage-bde -protectors -get C:`).

## 1. Boot the ISO

Download it from [archlinux.org/download](https://archlinux.org/download/) and write it to the USB stick:

```bash
dd bs=4M if=archlinux-x86_64.iso of=/dev/sdX conv=fsync oflag=direct status=progress
```

Or use [Ventoy](https://www.ventoy.net) (Linux and Windows): set up the stick once, then just copy ISO files onto it
and pick one at boot. The stick keeps working as normal storage.

Boot the stick, then:

```bash
loadkeys de                     # keyboard layout; list: localectl list-keymaps
setfont ter-132b                # bigger font, if the text is tiny
iwctl station wlan0 connect "Your Wi-Fi"    # Wi-Fi; Ethernet works by itself
ping -c 3 archlinux.org         # internet works?
timedatectl                     # "System clock synchronized: yes"?
```

## 2. Partitions

Find your disk with `lsblk`, then open it with `cfdisk /dev/nvme0n1` (choose GPT if asked) and create:

| Partition | Size | Type |
|---|---|---|
| EFI | 1 GiB | EFI System |
| root | the rest | Linux root (x86-64) |

**Dual boot:** create both in the free space. Windows has its own EFI partition, usually only 100 MB,
too small for Linux kernels, so Linux gets its own.

```bash
ESP=/dev/nvme0n1p1      # your new EFI partition
ROOT=/dev/nvme0n1p2     # your new root partition
```

## 3. Format and mount

Pick **A** or **B** for the root partition.

**A) Plain ext4**

```bash
mkfs.ext4 $ROOT
mount $ROOT /mnt
```

**B) Encrypted with LUKS2.** At every boot you type a passphrase to unlock the disk.
Forget it and the data is gone. Use the same keyboard layout as in step 1; it is set for boot by `chroot/10-locale.sh`.

```bash
cryptsetup luksFormat $ROOT     # type YES, then your passphrase twice
cryptsetup open $ROOT root      # unlock it as /dev/mapper/root
mkfs.ext4 /dev/mapper/root
mount /dev/mapper/root /mnt
```

**Both:** the EFI partition, readable by root only.

```bash
mkfs.fat -F 32 $ESP
mount --mkdir -o fmask=0077,dmask=0077 $ESP /mnt/boot
```

## 4. Install the base system

`amd-ucode` for AMD CPUs, `intel-ucode` for Intel. Add `linux-lts` for a backup kernel you can pick at boot.

```bash
pacstrap -K /mnt base linux linux-firmware amd-ucode nano sudo git
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

**Dual boot:** systemd-boot shows Windows only if its boot loader is on the same EFI partition.
Copy it from the **Windows** EFI partition (about 100 MB, check with `lsblk -f`):

```bash
mount --mkdir /dev/nvme0n1p1 /win
cp -r /win/EFI/Microsoft /boot/EFI/
umount /win && rmdir /win
```

## 5. Run the scripts

Inside the chroot. Each script asks before it runs:

```bash
git clone https://github.com/archlinux-fan/arch-install /root/arch-install
/root/arch-install/run.sh chroot
exit
umount -R /mnt
reboot
```

After the reboot log in as your user, connect with `nmtui`, then:

```bash
git clone https://github.com/archlinux-fan/arch-install ~/arch-install
~/arch-install/run.sh desktop
sudo rm -rf /root/arch-install
```

Reboot once more and start Hyprland with `start-hyprland`.
What every script does, the optional ones and how to skip the questions: [docs/scripts.md](docs/scripts.md).

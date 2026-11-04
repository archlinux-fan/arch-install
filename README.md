# Arch Linux + mango

Install Arch Linux with the mango desktop, step by step, even if it's your first time.
Arch has no installer with buttons: you type commands. This guide gives you every command
and says what it does, then small scripts do the rest and ask before every step.

- One package per line. Pacman, the package manager, asks `[Y/n]` for each one, so you install only what you want.
- A comment above every command in the scripts explains what it is and why it's there.
- Optional disk encryption (LUKS2), optional dual boot with Windows.
- Only official Arch packages, except one browser from the AUR.

![mango desktop with the Nord theme](https://raw.githubusercontent.com/archlinux-fan/arch-dots/main/screenshots/fastfetch.png)

mango is a tiling desktop: new windows fill the screen side by side, nothing overlaps, and you
work mostly with the keyboard. The look comes from [arch-dots](https://github.com/archlinux-fan/arch-dots), more screenshots there.

Read it as a website: [archlinux-fan.github.io/arch-install](https://archlinux-fan.github.io/arch-install/)

This page gets you from the USB stick to a working desktop. More:
[how the scripts work](docs/scripts.md) · [tips](docs/tips.md) · [your own private repo](docs/private-repo.md)

## Before you start

- **Back up your files.** The disk you install on is erased, except with dual boot.
- Plan about an hour. Keep this page open on a phone or another computer.
- A computer with UEFI: almost every computer from 2012 on.
  Turn **Secure Boot off** in the firmware settings (a key right after power on: F2, Del, F10 or Esc, it depends on the maker).
  It can go back on later: [tips](docs/tips.md#later-if-you-want).
- A USB stick of 2 GB or more (it gets erased) and internet. A network cable is easiest; Wi-Fi works too.
- **Dual boot** (keep Windows next to Arch): in Windows shrink its partition (Disk Management → right-click C: → Shrink Volume)
  and leave the space empty. If Windows uses BitLocker, save its recovery key first
  (Microsoft account → Devices, or `manage-bde -protectors -get C:`).
- Stuck? The [Arch Wiki installation guide](https://wiki.archlinux.org/title/Installation_guide) explains every step in more detail.

A few words you'll meet:

- **Command:** a line you type and run with Enter. Text after `#` is only an explanation; typing it does no harm.
- **root:** the administrator. On the USB stick you are root. Later `sudo` runs one command as root and asks your password.
- **Password prompts show nothing** while you type, not even dots. That's normal: type it and press Enter.
- **Package:** a program ready to install. `pacman` downloads and installs packages from Arch's servers.
- **Partition:** a part of a disk. **Formatting** prepares it for files and erases it.

## 1. Boot the USB stick

Download the ISO from [archlinux.org/download](https://archlinux.org/download/) (pick a mirror near you, the file is `archlinux-x86_64.iso`).

Write it to the USB stick with [Ventoy](https://www.ventoy.net) (Windows and Linux): set up the stick once,
then copy the ISO file onto it like any file. The stick keeps working as normal storage.
On Linux you can also write it directly, where `/dev/sdX` is the stick (check with `lsblk`; the wrong name erases another disk):

```bash
dd bs=4M if=archlinux-x86_64.iso of=/dev/sdX conv=fsync oflag=direct status=progress
```

Plug the stick in, turn the computer on and press the boot menu key (F12, F11, F8 or Esc, it depends on the maker).
Pick the USB stick (with UEFI in its name, if it shows twice), then *Arch Linux install medium*.
After a minute you see `root@archiso ~ #`: the computer waits for commands.

```bash
loadkeys uk                     # your keyboard layout (uk, de, fr ...); the stick starts with the US one
setfont ter-132b                # bigger letters, if the text is tiny
ping -c 3 archlinux.org         # internet works? three answers = yes
timedatectl                     # the clock: "System clock synchronized: yes"?
```

All keyboard layouts: `localectl list-keymaps` (q quits the list). With a cable the internet works by itself.
For Wi-Fi:

```bash
iwctl device list                       # your Wi-Fi card, usually wlan0
iwctl station wlan0 get-networks        # networks in range
iwctl station wlan0 connect "Your Wi-Fi"   # asks for the Wi-Fi password
```

## 2. Partitions

The disk gets two partitions: a small **EFI** partition, where the computer looks for the boot menu,
and **root** for the system, the programs and your files.

```bash
lsblk                           # disks and their sizes
```

`nvme0n1` is an NVMe SSD, `sda` a SATA disk. The USB stick is in the list too: it's the one with the size of your stick.
Partitions get a number: `nvme0n1p1` or `sda1`. Below, replace `nvme0n1` with your disk.

```bash
cfdisk /dev/nvme0n1             # choose "gpt" if it asks
```

cfdisk is a menu: arrow keys move, Enter picks.

1. To erase the whole disk: select each old partition → **Delete**. Everything on them is gone.
   **Dual boot:** delete nothing, use only the free space.
2. **Free space** → **New** → type `1G` → **Type** → **EFI System**.
3. **Free space** → **New** → Enter (the rest of the space) → **Type** → **Linux root (x86-64)**.
4. **Write** → type `yes` → **Quit**.

**Dual boot:** Windows has its own EFI partition, usually only 100 MB, too small for Linux, so Linux gets its own.

Run `lsblk` again and give the two new partitions short names. The next commands use them;
if you restart the computer before the end, set them again.

```bash
ESP=/dev/nvme0n1p1      # your new EFI partition
ROOT=/dev/nvme0n1p2     # your new root partition
```

## 3. Format and mount

Formatting puts a file system on a partition. Mounting attaches it to a folder: everything written to `/mnt`
lands on your new root partition.

Pick **A** or **B** for the root partition.

**A) Plain:** simple, no password at boot.

```bash
mkfs.ext4 $ROOT
mount $ROOT /mnt
```

**B) Encrypted with LUKS2:** if the laptop is stolen, nobody can read your files. At every boot you type a passphrase.
Forget it and the data is gone for good. Type it with the same keyboard layout as in step 1; the scripts set that layout for boot.

```bash
cryptsetup luksFormat $ROOT     # type YES in capitals, then your passphrase twice
cryptsetup open $ROOT root      # unlock it; it is now /dev/mapper/root
mkfs.ext4 /dev/mapper/root
mount /dev/mapper/root /mnt
```

**Both:** the EFI partition, readable by root only.

```bash
mkfs.fat -F 32 $ESP
mount --mkdir -o fmask=0077,dmask=0077 $ESP /mnt/boot
```

## 4. Install the base system

`pacstrap` downloads the smallest working Arch system and installs it in `/mnt`:

- `base` the basic system, `linux` the kernel, `linux-firmware` the files your Wi-Fi, graphics and other chips need
- `amd-ucode` for an AMD processor or `intel-ucode` for Intel: fixes for the processor.
  Not sure? `grep -m1 'model name' /proc/cpuinfo`
- `dosfstools` checks the EFI partition at boot, `nano` a simple text editor (Ctrl+O saves, Ctrl+X quits),
  `sudo` see above, `git` downloads the scripts
- Add `linux-lts` for a second, older kernel you can pick in the boot menu if the new one has a problem.

```bash
pacstrap -K /mnt base linux linux-firmware amd-ucode dosfstools nano sudo git
genfstab -U /mnt >> /mnt/etc/fstab     # which partitions to mount at every boot
arch-chroot /mnt                       # step inside the new system
```

From now on the commands run inside your new system; the prompt changes to `[root@archiso /]#`.

**Dual boot:** the boot menu shows Windows only if its boot files are on the same EFI partition.
Copy them from the **Windows** EFI partition (about 100 MB, find it with `lsblk -f`: type `vfat`):

```bash
mount --mkdir /dev/nvme0n1p1 /win
cp -r /win/EFI/Microsoft /boot/EFI/
umount /win && rmdir /win
```

## 5. Run the scripts

Still inside the new system. `run.sh` runs the scripts of a folder one after another and asks
`Run chroot/10-locale.sh? [Y/n]` before each; Enter means yes. They ask for your time zone, language,
keyboard, a name for the computer, your user name and passwords. Pacman asks before every package: Enter installs it.

```bash
git clone https://github.com/archlinux-fan/arch-install /root/arch-install
/root/arch-install/run.sh chroot
exit                            # leave the new system
umount -R /mnt
reboot                          # take the USB stick out when the screen goes dark
```

The computer starts from the disk: the boot menu picks Arch Linux after 3 seconds. Type the LUKS passphrase
if you chose B, then log in with your user name and password. This text screen is the console.

Connect to the internet with `nmtui` (a menu: Activate a connection → your Wi-Fi → password; a cable works by itself), then:

```bash
git clone https://github.com/archlinux-fan/arch-install ~/arch-install
~/arch-install/run.sh desktop
sudo rm -rf /root/arch-install
```

These install the desktop and the programs; `sudo` asks your password. When asked for a dotfiles repo URL,
paste `https://github.com/archlinux-fan/arch-dots` for the desktop in the pictures, or press Enter to skip.
A private repo is only for your own settings ([what's that](docs/private-repo.md)); press Enter if you don't have one.

Reboot (`reboot`) and log in: mango starts by itself. Without arch-dots type `mango`.
First keys (Super is the Windows key): **Super+Return** terminal, **Super+Space** app menu, **Super+Q** closes a window,
**Super+1 … 0** switch workspace. More keys: [arch-dots](https://github.com/archlinux-fan/arch-dots#keys).

What every script does, the optional ones and how to skip the questions: [docs/scripts.md](docs/scripts.md).
Keeping the system up to date: [tips](docs/tips.md).

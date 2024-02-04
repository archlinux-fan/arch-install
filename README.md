# Arch Basic Install Commands-Script

In this repository you will find packages-scripts for the base install of Arch Linux and the Gnome, KDE, Cinnamon and Xfce desktop environments. More to come for Windows Managers soon.
Modify the packages to your liking, make the script executable with chmod +x scriptname and then run with ./scriptname.
A script for the base install on MBR/Legacy will be available soon.
Remember that the first part of the Arch Linux install is manual, that is you will have to partition, format and mount the disk yourself. Install the base packages and make sure to inlcude git so that you can clone the repository in chroot.

Follow official instalation guide: - https://wiki.archlinux.org/title/Installation_guide

A small summary:

If Dual boot with windows is needed:
1. Na winsih naredi free plac za 2 particije. 800MB za Dual boot, kjer sta kernela (navadni in LTS), ter drugo kjer bo linux.


1. Z Rufusom inštaliraj Arch .iso fajl. Naj bo GPT, ker MBR je zastarelo in ne dela za EFI oz bolj nov UEFI (rabiš za dual boot, če ne je boot samo z BIOSom)
2. v BIOSU disablaj secure boot.
3. Run Arch from USB-ja
4. If needed, load your keymap
5. Connect to the internet
6. Set time
7. Refresh the servers with pacman -Syy
8. Partition the disk
9. Format the partitions
10. Mount the partitions
11. Install the base packages into /mnt (pacstrap /mnt base linux linux-firmware git vim intel-ucode (or amd-ucode))
12. Generate the FSTAB file with genfstab -U /mnt >> /mnt/etc/FSTAB
13. Chroot in with arch-chroot /mnt
14. Download the git repository with git clone https://gitlab.com/archlinux-fan/arch-install.git
15. Start the installation script





*4. Set the console keyboard layout and font*
List them first if you dont know the correct one with (they are all located at /usr/share/kbd/keymaps/):
```Bash
localectl list-keymaps
```

*Load them (examples: slovene, us, es)*
```Bash
loadkeys slovene
```


*Set console fonts *
List them first, if you dont know which ones to use:
```Bash
ls /usr/share/kbd/consolefonts/
```
else (lat2-16 - for slovenian)
```Bash
setfont lat2-16
```

*5. Connect to the internet*
Ensure your network interface (ETH card, Wifi card,..) is listed and enabled, for example with:
```Bash
ip link
```
enable the network card otherwise with 
```Bash
ip link set DEVICE up
```

*Connect to the internet:*
- Plugin in ethernet cable or
- Wi-Fi — connect to your wireless network using iwctl.
```Bash
iwctl
device-list
station wlan0 get-networks   # 'wlan0' zamenjaš z imenom svoje kartice 
station wlan0 connnect 'ime wifi-ja' #vpip še pass
```

The connection may be verified with ping:
```Bash
ping archlinux.org
```

*6. Update the system clock*
In the live environment systemd-timesyncd is enabled by default and time will be synced automatically once a connection to the internet is established.
Use timedatectl to ensure the system clock is accurate:
```Bash
timedatectl
```


*7. Sinhronize packages*
```Bash
pacman -Sy # (Sinhroniziraj pakete)
pacman -Sy archlinux-keyring # (sinhronizira in inštalira še to zadnjo verzijo, ampak najbrš je itak že na USB nova zadnja)
```


*8. Partition the disks*
list partitions and disks
```Bash
lsblk
```

*Create partitions. Run the cfdisk tool with, where you want ti install linux and boot partition (maybe swap too? I haven't been using it for many years)
```Bash
cfdisk /dev/disk_name (nvme0n1, sda1,...)
```

narediš boot particijo 800M (če imaš Win + Linux, drugače je lahko manjša malo. Ne pa dosti, ker rabiš še LTS kernel za backup). Za TYPE izbereš EFI System
narediš root partcijo z vsem ostalim prostorom (če nočeš swap particije). Za TYPE pustiš Linux filesystem.
Write - vpiši "yes" in ENTER

*9. Format the partitions*
```Bash
mkfs.fat -F 32 /dev/efi_system_partition
mkfs.ext4 /dev/root_partition
```

*10. Mount the file systems*
 + morda potem še win EFI particije, če rabiš dual boot z winsi
```Bash
Mount big partion (file system)
mount /dev/ime_diska /mnt

Mount the boot partion with GRUB and kernels
mkdir /mnt/boot
mount /dev/ime_diska /mnt/boot
```
test again with
```Bash
lsblk
```

*11. Install essential packages*
Speed tip:
```Bash
pacman -Sy nano
nano /etc/pacman.conf
uncomment ParalelDownloads = 20
```

Če je počasno pa z reflektorjem dobi najhitrješe mirrorje. Drugače bo to itak v zadnji skripti/koraku narejeno
```Bash
pacman -S reflector
reflector
```

install base firmware (-i je pomoje da te vpraša vmes da potrdiš. -K je pa da nek prazen keyring vmes. Acceptaj default)
```Bash
pacstrap -Ki /mnt base linux linux-lts linux-firmware (linux-lts je še drugi kernel zraven z long term support (bolj stabilen). Če je z enim nekaj narobe zalaufaš drugega potem na začetku pri izbiri v GRUB)
```


*12. Mountaj particije fiksno za zmeraj. Prej so bile samo na USB*
Generate file system table (fstab)
```Bash
genfstab -U /mnt >> /mnt/etc/fstab
```
Preveriš lahko z:
```Bash
cat /mnt/etc/fstab
```


*13. Chroot into the newly installed system*
Change root into the new system
```Bash
arch-chroot /mnt
```


*OPTIONAL če imaš še windows particijo in rabiš dual boot potem:*
```Bash
pacman -S os-prober ntfs-3g (morda oba rabiš samo začasno. Ne vem pa kaj je pol ko se kernel updata)
sudo nano /etc/default/grub
uncomment GRUB_DISABLE_OS_PROBER_FALSE
```
For Windows installed in UEFI mode, make sure the EFI system partition containing the Windows Boot Manager (bootmgfw.efi) is mounted. Run os-prober as root to detect and generate an entry for it
```Bash
mkdir /mnt/win11
mount /dev/ime_win_EFI_particije /mnt/win
```

*14. Posnami git, sudo in stakni skripto*
Download the git repository with git clone --depth 1 https://gitlab.com/archlinux-fan/arch-install.git

```Bash
pacman -Sy git sudo nano
```

```Bash
git clone --depth 1 https://github.com/archlinux-fan/arch-install.git # mora bit public najbrš  # ('--depth 1' is so that it downloads latest version files only, not the whole history)


*15 Run the installation script*
cd arch-install
sudo sh base-uefi.sh
```

ne vem kaj je to
```Bash
sudo pacman-key --init # The command sets up the key management system.
sudo pacman-key --populate archlinux # The command adds the necessary keys to trust official Arch Linux packages
```


Exit the chroot environment by typing exit or pressing Ctrl+d.

Optionally manually unmount all the partitions with umount -R /mnt: this allows noticing any "busy" partitions, and finding the cause with fuser(1).

Finally, restart the machine by typing reboot: any partitions still mounted will be automatically unmounted by systemd. 
Remember to remove the installation medium and then login into the new system with the root account



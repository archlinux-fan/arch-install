# Arch Basic Install Commands-Script

In this repository you will find packages-scripts for the base install of Arch Linux and the Gnome, KDE, Cinnamon and Xfce desktop environments. More to come for Windows Managers soon.
Modify the packages to your liking, make the script executable with chmod +x scriptname and then run with ./scriptname.
A script for the base install on MBR/Legacy will be available soon.
Remember that the first part of the Arch Linux install is manual, that is you will have to partition, format and mount the disk yourself. Install the base packages and make sure to inlcude git so that you can clone the repository in chroot.

Follow official instalation guide: - https://wiki.archlinux.org/title/Installation_guide

A small summary:

1. If needed, load your keymap
2. Refresh the servers with pacman -Syy
3. Partition the disk
4. Format the partitions
5. Mount the partitions
6. Install the base packages into /mnt (pacstrap /mnt base linux linux-firmware git vim intel-ucode (or amd-ucode))
7. Generate the FSTAB file with genfstab -U /mnt >> /mnt/etc/FSTAB
8. Chroot in with arch-chroot /mnt
9. Download the git repository with git clone https://gitlab.com/archlinux-fan/arch-install.git
10. cd arch-basic
11. chmod +x base-uefi.sh
12. run with ./base-uefi.sh


1. Na winsih naredi free plac za 2 particije. 800MB za Dual boot, kjer sta kernela (navadni in LTS), ter drugo kjer bo linux.

2. Z Rufusom inštaliraj Arch .iso fajl. Naj bo GPT, ker MBR je zastarelo in ne dela za EFI oz bolj nov UEFI (rabiš za dual boot, če ne je boot samo z BIOSom)

3. v BIOSU disablaj secure boot.

4. Zalaufaj Arch iz USB-ja

5. For slovenian keyboard:
List them first if you dont know the correct one with:
```Bash
localectl list-keymaps
```

Load keys
```Bash
loadkeys slovene
```

Console fonts are located in /usr/share/kbd/consolefonts/. Set them
```Bash
setfont lat2-16
```

6. če imaš že preko kabla internet za test če dela
```Bash
ping 8.8.8.8 
```

6a. Zrihtaj wifi network drugače  
```Bash
iwctl
device-list
station wlan0 get-networks   # 'wlan0' zamenjaš z imenom svoje kartice 
station wlan0 connnect 'ime wifi-ja' #vpip še pass
```


```Bash
pacman -Sy # (Sinhroniziraj pakete)
pacman -Sy archlinux-keyring # (sinhronizira in inštalira še to zadnjo verzijo, ampak najbrš je itak že na USB nova zadnja)
```


7. Naredi particije
zlistaj particije in diske
```Bash
lsblk
```

pojdi v tool za particije. Zalaufaš ga z cfdisk /dev/ime_diska, kamor bi rad inštaliral linux in boot particijo
```Bash
cfdisk /dev/ime_diska (nvme0n1, sda1,...)
```

narediš boot particijo 800M (če imaš Win + Linux, drugače je lahko manjša malo. Ne pa dosti, ker rabiš še LTS kernel za backup). Za TYPE izbereš EFI System
narediš root partcijo z vsem ostalim prostorom (če nočeš swap particije). Za TYPE pustiš Linux filesystem.
Write - vpiši "yes" in ENTER

8. Formatiraj particije
```Bash
mkfs.fat -F 32 /dev/efi_system_partition
mkfs.ext4 /dev/root_partition
```

9. Mount obeh particij + morda potem še win EFI particije, če rabiš dual boot z winsi
```Bash
Mount big partion (file system)
mount /dev/ime_diska /mnt
mkdir /mnt/boot
mount /dev/ime_diska /mnt/boot
```
preveri če vse štima
```Bash
lsblk
```

10. Install stuff
Speed tip:
```Bash
pacman -Sy nano
nano /etc/pacman.conf
uncomment ParalelDownloads = 5
```

install base firmware (-i je pomoje da te vpraša vmes da potrdiš. -K je pa da nek prazen keyring vmes. Acceptaj default)
```Bash
pacstrap -Ki /mnt base linux linux-lts linux-firmware
```

11. Mountaj particij fiksno za zmeraj. Prej so bile samo na USB
Generate file system table (fstab)
```Bash
genfstab -U /mnt >> /mnt/etc/fstab
```
Preveriš lahko z:
```Bash
cat /mnt/etc/fstab
```

#12. Go to chroot to our new root on nvme0n1p5
```Bash
arch-chroot /mnt
```


13. OPTIONAL če imaš še windows particijo in rabiš dual boot potem:
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

14. Posnami git, sudo in stakni skripto
Download the git repository with git clone https://github.com/archlinux-fan/arch-install.git

```Bash
pacman -Sy git sudo nano
```

```Bash
git clone https://github.com/archlinux-fan/arch-install.git # mora bit public najbrš

cd arch-install
chmod +x base-uefi.sh
run with sudo ./base_uefi.sh
```

AUR
Install yay, ker ga rabiš za naslednjo skripto
```Bash
./yay.sh
```


Exit the chroot environment by typing exit or pressing Ctrl+d.

Optionally manually unmount all the partitions with umount -R /mnt: this allows noticing any "busy" partitions, and finding the cause with fuser(1).

Finally, restart the machine by typing reboot: any partitions still mounted will be automatically unmounted by systemd. Remember to remove the installation medium and then login into the new system with the root acco

ne vem kaj je to
```Bash
sudo pacman-key --init
sudo pacman-key --populate archlinux
```


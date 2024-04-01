# Arch Basic Install Commands-Script

Follow official instalation guide: - https://wiki.archlinux.org/title/Installation_guide

A small summary:

If Dual boot with windows is needed:
1. Na winsih naredi free plac za 2 particije. 800MB za Dual boot, kjer sta kernela (navadni in LTS), ter drugo kjer bo linux.
----
1. Z Rufusom inštaliraj Arch .iso fajl na USB. Naj bo GPT, ker MBR je zastarelo in ne dela za EFI oz bolj nov UEFI (rabiš za dual boot, če ne je boot samo z BIOSom)
2. v BIOSU disablaj secure boot.
----
Run Arch from USB-ja
1. If needed, load your keymap
2. Connect to the internet
3. Set time
4. Refresh the servers with `pacman -Syy`
5. Partition the disk
6. Format the partitions
7. Mount the partitions
8. Install the base packages into /mnt (`pacstrap /mnt base linux linux-firmware`)
9. Generate the FSTAB file with `genfstab -U /mnt >> /mnt/etc/FSTAB`
10. Chroot in with `arch-chroot /mnt`
11. Download the git repository with `git clone https://gitlab.com/archlinux-fan/arch-install.git`
12. Start the installation script





*1. Set the console keyboard layout and font*
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

*2. Connect to the internet*
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
device list
station wlan0 get-networks   # 'wlan0' zamenjaš z imenom svoje kartice 
station wlan0 connnect 'ime wifi-ja' #vpip še pass
```

The connection may be verified with ping:
```Bash
ping archlinux.org
```

*3. Update the system clock*
In the live environment systemd-timesyncd is enabled by default and time will be synced automatically once a connection to the internet is established.
Use timedatectl to ensure the system clock is accurate:
```Bash
timedatectl
```


*4. Sinhronize packages*
```Bash
pacman -Sy # (Sinhroniziraj pakete)
pacman -Sy archlinux-keyring # (sinhronizira in inštalira še to zadnjo verzijo, ampak najbrš je itak že na USB nova zadnja)
```

```Bash
sudo pacman-key --init # The command sets up the key management system.
sudo pacman-key --populate archlinux # The command adds the necessary keys to trust official Arch Linux packages
```
#In summary:
#Installing archlinux-keyring and running the pacman-key commands are essential steps for ensuring package authenticity and security in Arch Linux. They work together to establish a trust chain and verify the signatures of packages you download, protecting your system from potential threats.


*5. Partition the disks*
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

*6. Format the partitions*
```Bash
mkfs.fat -F 32 /dev/efi_system_partition
mkfs.ext4 /dev/root_partition
```

*7. Mount the file systems*
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

*8. Install essential packages*
Speed tip:
```Bash
pacman -Sy nano
nano /etc/pacman.conf
uncomment ParalelDownloads = 20
```

Uncomment VerbosePkgLists to display name, version and size of target packages formatted as a table for upgrade, sync and remove operations.
```Bash
VerbosePkgLists
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


*9. Mountaj particije fiksno za zmeraj. Prej so bile samo na USB*
Generate file system table (fstab)
```Bash
genfstab -U /mnt >> /mnt/etc/fstab
```
Preveriš lahko z:
```Bash
cat /mnt/etc/fstab
```


*10. Chroot into the newly installed system*
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
For Windows installed in UEFI mode, make sure the EFI system partition containing the Windows Boot Manager (`bootmgfw.efi`) is mounted. Run os-prober as root to detect and generate an entry for it
```Bash
mkdir /mnt/win11
mount /dev/ime_win_EFI_particije /mnt/win
```

*11. Posnami git, sudo in stakni skripto*
Download the git repository with `git clone --depth 1 https://gitlab.com/archlinux-fan/arch-install.git`

```Bash
pacman -Sy git sudo nano
```

```Bash
git clone --depth 1 https://github.com/archlinux-fan/arch-install.git # mora bit public najbrš  # ('--depth 1' is so that it downloads latest version files only, not the whole history)
```

*12 Run the installation script*
```Bash
cd arch-install
sudo sh base-uefi.sh
```


Exit the chroot environment by typing exit or pressing Ctrl+d.

Optionally manually unmount all the partitions with umount -R /mnt: this allows noticing any "busy" partitions, and finding the cause with fuser(1).

Finally, restart the machine by typing reboot: any partitions still mounted will be automatically unmounted by systemd. 
Remember to remove the installation medium and then login into the new system with the root account



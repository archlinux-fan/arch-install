#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Ljubljana /etc/localtime
hwclock --systohc

# Uncomment languages before locale-generation. Or just add them at the bottom of the file /etc/locale.gen:
echo "en_US.UTF-8 UTF-8
sl_SI.UTF-8 UTF-8" >> /etc/locale.gen

# locale-generation
locale-gen

# Select prefered languages in /etc/locale.conf:
echo "LANG=en_US.UTF-8
LC_CTYPE=sl_SI.UTF-8
LC_NUMERIC=sl_SI.UTF-8
LC_TIME=sl_SI.UTF-8
LC_COLLATE=sl_SI.UTF-8
LC_MONETARY=sl_SI.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_PAPER=sl_SI.UTF-8
LC_NAME=sl_SI.UTF-8
LC_ADDRESS=sl_SI.UTF-8
LC_TELEPHONE=sl_SI.UTF-8
LC_MEASUREMENT=sl_SI.UTF-8
LC_IDENTIFICATION=sl_SI.UTF-8
LC_ALL=" >> /etc/locale.conf

# Select prefered languages for console in /etc/vconsole.conf
echo "KEYMAP=slovene
FONT=lat2-16
FONT_MAP=8859-2" >> /etc/vconsole.conf

# Hostname settings
echo "arch" >> /etc/hostname

# Hosts settings
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1        localhost" >> /etc/hosts
echo "127.0.1.1  arch.localdomain arch" >> /etc/hosts

# Users and pass
# Set root pass
echo root:password | root

# Add user and add it to groups
useradd -m marko
echo marko:password | root
usermod -aG wheel,storage,audio,video,power -s /bin/bash marko

# Install grub and fix boot (os-prober rabiš če imaš še windows particijo)
sudo pacman -S grub efibootmgr dosfstools mtools base-devel

# Run grub install
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

# linux-headers
sudo pacman -S linux-headers

# bluetooth  
sudo pacman -S bluez bluez-utils 
systemctl enable bluetooth

# network and printer automatic discovery
# Avahi provides local hostname resolution using a "hostname.local" naming scheme. To enable it, install the nss-mdns package and start/enable avahi-daemon.service.
# Then, edit the file /etc/nsswitch.conf and change the hosts line to include mdns_minimal [NOTFOUND=return] before resolve and dns:
# hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns

sudo pacman -S avahi nss-mdns
systemctl enable avahi-daemon
# click/enable option mdns in firewall GUI config "services" option - for printer to work

# printer
# printer needs ghostscript to print to pdf
sudo pacman -S cups ghostscript
systemctl enable cups.service

# Firewall
sudo pacman -S firewalld 
systemctl enable firewalld


# network (there is no other wifi tool otherwise. Use iwctl )
sudo pacman -S networkmanager
systemctl enable NetworkManager

# mirorrs automatic sorting 
sudo pacman -S reflector
systemctl enable reflector.timer

# trim SSD drive
systemctl enable fstrim.timer


# network-manager-applet dialog wpa_supplicant avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset  flatpak sof-firmware nss-mdns acpid terminus-font

# systemctl enable sshd
# systemctl enable acpid
# systemctl enable tlp # You can comment this command out if you didn't install tlp, see above


# sound
sudo pacman -S pipewire pipewire-pulse wireplumber

# echo "marko ALL=(ALL) ALL" >> /etc/sudoers.d/marko - to ne dela
printf "EDITOR=nano visudo"
printf "Uncomment %wheel ... "
printf "Add the below line which makes it so that you don't have to reinsert password in each terminal a user uses sudo in"
printf "Defaults !tty_tickets"
printf " "

sleep 5

printf "microcode + graphic card drivers install"
printf "sudo pacman -S amd-ucode mesa libva-mesa-driver mesa-vdpau xf86-video-amdgpu" # xf86-video-vesa libva-utils # amd grafika
printf "sudo pacman -S intel-ucode # intel grafika"
printf "sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings # nvidia grafika"
printf "mesa-utils mesa-vdpau za hardware acceleration?"
printf " "
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"


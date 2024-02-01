#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Ljubljana /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "sl_SI.UTF-8 UTF-8" >> /etc/locale.conf
echo "KEYMAP=slovene
FONT=lat2-16
FONT_MAP=8859-2" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | root

useradd -m marko
echo marko:password | root
usermod -G wheel,storage,audio,video,power -s /bin/bash marko

# Install grub and fix boot (os-prober rabiš če imaš še windows particijo)
pacman -S grub efibootmgr dosfstools mtools

# Run grub install
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
grub-mkconfig -o /boot/grub/grub.cfg


# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

# pacman -S networkmanager bluez bluez-utils base-devel linux-headers reflector firewalld
# network-manager-applet dialog wpa_supplicant avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset  flatpak sof-firmware nss-mdns acpid terminus-font

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable firewalld
systemctl enable reflector.timer
systemctl enable fstrim.timer

# systemctl enable cups.service
# systemctl enable sshd
# systemctl enable avahi-daemon
# systemctl enable acpid
# systemctl enable tlp # You can comment this command out if you didn't install tlp, see above




# echo "marko ALL=(ALL) ALL" >> /etc/sudoers.d/marko - to ne dela
printf "EDITOR=nano visudo"
printf "Uncomment %wheel ... "
printf "Add the below line which makes it so that you don't have to reinsert password in each terminal a user uses sudo in"
printf "Defaults !tty_tickets"

printf "microcode + graphic card drivers install"
printf "pacman -S amd-ucode xf86-video-amdgpu"
printf "pacman -S intel-ucode"
printf "pacman -S --noconfirm nvidia nvidia-utils nvidia-settings"
printf " "

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"


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



# če imaš še windows particijo in rabiš dual boot potem:
pacman -S os-prober
sudo nano /etc/default/grub
# uncomment GRUB_DISABLE_OS_PROBER_FALSE

# For Windows installed in UEFI mode, make sure the EFI system partition containing the Windows Boot Manager (bootmgfw.efi) is mounted. Run os-prober as root to detect and generate an entry for it
mkdir /mnt/win11
mount /dev/ime_win_EFI_particije /mnt/win

# Run grub install
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

# pacman -S grub efibootmgr networkmanager bluez bluez-utils # network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

# pacman -S amd-ucode xf86-video-amdgpu
# pacman -S intel-ucode 
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

systemctl enable NetworkManager
systemctl enable bluetooth
# systemctl enable cups.service
# systemctl enable sshd
# systemctl enable avahi-daemon
# systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
# systemctl enable reflector.timer
# systemctl enable fstrim.timer
# systemctl enable libvirtd
# systemctl enable firewalld
# systemctl enable acpid





# echo "marko ALL=(ALL) ALL" >> /etc/sudoers.d/marko - to ne dela
printf "EDITOR=nano visudo"
printf "Uncomment %wheel ... "
printf "Add the below line which makes it so that you don't have to reinsert password in each terminal a user uses sudo in"
printf Defaults !tty_tickets"
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"


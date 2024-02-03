#!/bin/bash

# Set the time zone:
ln -sf /usr/share/zoneinfo/Europe/Ljubljana /etc/localtime

# Run hwclock(8) to generate /etc/adjtime:
hwclock --systohc

# Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed UTF-8 locales. Or just add them at the bottom of the file:
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "sl_SI.UTF-8 UTF-8" >> /etc/locale.gen

# Generate the locales by running:
locale-gen

# Create the /etc/locale.conf file, and set the LANG variable accordingly. Select prefered languages:
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

# /etc/X11/xorg.conf.d00-keyboard.conf file is need for Slovenian keyboard
cp /etc/X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d

# If you set the console keyboard layout, make the changes persistent in /etc/vconsole.conf
echo "KEYMAP=slovene
FONT=lat2-16" >> /etc/vconsole.conf
# To spodaj nisem ziher, če je res potreno dodat
echo "FONT_MAP=8859-2" >> /etc/vconsole.conf

# Hostname settings
echo "Chose the hostname for your computer: (one word, small letters)"
read hostname
echo $hostname >> /etc/hostname

# Hosts settings
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1        localhost" >> /etc/hosts
echo "127.0.1.1  $hostname.localdomain $hostname" >> /etc/hosts

# Users and pass
# Set root pass
echo "Chose the password for the root user: (one word, small letters)"
read rootpass
echo root:$rootpass | chpasswd # chpasswd is a command to create pass

# Add user and add it to groups
echo "Chose your username: (one word, small letters)"
read username
echo "Chose the password for the $username user: (one word, small letters)"
read userpass
useradd -m $username
echo $username:$userpass | chpasswd
usermod -G wheel -a $username

# Install grub and fix boot (os-prober rabiš če imaš še windows particijo)
sudo pacman -S grub efibootmgr dosfstools mtools base-devel

# Run grub install
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

# linux-headers - you only need the headers in the case you want to build custom kernel modules and/or want to use DKMS packages
# sudo pacman -S linux-headers

# network (there is no other wifi tool otherwise. Use iwctl )
sudo pacman -S networkmanager
systemctl enable NetworkManager

# bluetooth (needed if you use bluetooth mouse or keyboard)
sudo pacman -S bluez bluez-utils 
systemctl enable bluetooth

# sound
pacman -S pipewire pipewire-pulse wireplumber


# echo "marko ALL=(ALL) ALL" >> /etc/sudoers.d/marko - to ne dela
printf "\e[1;32mUncomment %wheel ALL=(ALL:ALL) ALL in sudoers file with\e[0m"
printf "sudo nano /etc/sudoers or"
printf "EDITOR=nano visudo"
printf "Uncomment %wheel ... "
printf "Add the below line which makes it so that you don't have to reinsert password in each terminal a user uses sudo in"
printf "Defaults !tty_tickets"
printf " "

sleep 5


#  'intel-media-driver: backend for Intel GPUs (>= Broadwell)'
#  'libva-intel-driver: backend for Intel GPUs (<= Haswell)'
#  'libva-mesa-driver: backend for AMD and Nvidia GPUs'

printf "microcode + graphic card drivers install"
printf "sudo pacman -S amd-ucode" # cpu microcodes
printf " "
printf "sudo pacman -S mesa" # provides the DRI driver for 3D acceleration
printf "sudo pacman -S xf86-video-amdgpu" # DDX driver (which provides 2D acceleration in Xorg) 
printf " "
printf " "
printf "sudo pacman -S intel-ucode" # intel cpu
printf "sudo pacman -S intel-media-driver" # intel integrated gpu and Arc
printf " "
printf " "
printf "sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings # nvidia grafika"
printf " "
printf " "
printf "sudo pacman -S libva-mesa-driver" # VA-API drivers
printf "sudo pacman -S mesa-vdpau" # VDPAU drivers - najbrš ne rabim sploh. Zastarela NVIDIA codecs thing
printf "sudo pacman -S libva-utils" # libva-utils
printf " "
printf " "
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"



: <<'END_COMMENT'
Mesa:

Mesa is the core open-source implementation of the OpenGL and Vulkan graphics APIs.
It provides basic 3D rendering capabilities without hardware acceleration.
It's the foundation for other packages like mesa-vdpau and libva-mesa-driver.
libva:

libva (Video Acceleration API) is an open-source library that allows applications to access hardware video acceleration features on various GPUs.
It acts as a middle layer between applications and specific driver implementations like libva-intel-driver or libva-mesa-driver.
mesa-vdpau:

mesa-vdpau is a plugin for Mesa that adds support for the VDPAU (Video Decode and Presentation API for Unix) API.
VDPAU is an older API primarily used by NVIDIA GPUs for hardware-accelerated video decoding.
It's less widely supported than VA-API but might be relevant for older NVIDIA cards.
libva-mesa-driver:

libva-mesa-driver is another plugin for Mesa that adds support for the VA-API.
This is the more modern and widely supported approach for hardware video acceleration on various GPUs, including Intel, AMD, and some NVIDIA cards.
In summary:

Mesa: Core graphics API implementation (OpenGL, Vulkan)
libva: Library for accessing hardware video acceleration features
mesa-vdpau: Plugin for Mesa supporting VDPAU (mostly NVIDIA)
libva-mesa-driver: Plugin for Mesa supporting VA-API (various GPUs)
Which one do you need?

It depends on your specific needs and hardware.
For basic 3D graphics processing, you only need Mesa.
For hardware-accelerated video decoding/encoding, you need either mesa-vdpau (older NVIDIA) or libva-mesa-driver (VA-API on various GPUs).
Consult your distribution's documentation or GPU specs to determine which option is compatible and suitable for your setup.

END_COMMENT

#!/bin/bash

# In Bash, set -e is a powerful option that controls how the script handles errors during execution. Let's break it down:
# 	set: This is a built-in command in Bash used to manage shell options and variables.
# 	-e: This is a flag passed to the set command, representing the specific option you want to modify. In this case, -e stands for "exit on error."
set -e 

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################


sh 010-set-timezone*
sh 011-set-time*
	
sh 020-set-locale*

sh 030-hosts*

sh 040-user-group*

sh 050-grub*

# linux-headers - you only need the headers in the case you want to build custom kernel modules and/or want to use DKMS packages
# sudo pacman -S linux-headers

sh 060-network*

sh 070-bluetooth*

sh 080-sound*


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
printf "sudo pacman -S xf86-video-amdgpu" # DDX driver (which provides 2D acceleration in Xorg - not needed at all? Eric Dubois removes this) 
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


echo
tput setaf 6
echo "################################################################"
echo "###### KDFONTOP message is gone"
echo "################################################################"
tput sgr0
echo


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










: <<'END_COMMENT'

   [ -d arc-theme ] && rm -rf arc-theme
  # if there is no hidden folder then make one
  [ -d $HOME"/.themes" ] || mkdir -p $HOME"/.themes"
  cp -rf /tmp/at/share/themes/Arc $HOME"/.themes"
  cp -rf /tmp/at/share/themes/Arc-Dark $HOME"/.themes"
  cp -rf /tmp/at/share/themes/Arc-Darker $HOME"/.themes"

  mv $HOME"/.themes/Arc" $HOME"/.themes/Arc-"$choice
  mv $HOME"/.themes/Arc-Dark" $HOME"/.themes/Arc-"$choice"-Dark"
  mv $HOME"/.themes/Arc-Darker" $HOME"/.themes/Arc-"$choice"-Darker"

  echo "################################################################"
  echo "Renaming the content of the index.theme"
  echo "Arc-$choice-Darker"
  find $HOME"/.themes/Arc-"$choice"-Darker" -name "index.theme" -type f -exec sed -i 's/'Name=Arc-Darker'/'Name=Arc-$choice-Darker'/g' {}  \;
  find $HOME"/.themes/Arc-"$choice"-Darker" -name "index.theme" -type f -exec sed -i 's/'GtkTheme=Arc-Darker'/'GtkTheme=Arc-$choice-Darker'/g' {}  \;
  find $HOME"/.themes/Arc-"$choice"-Darker" -name "index.theme" -type f -exec sed -i 's/'MetacityTheme=Arc-Darker'/'MetacityTheme=Arc-$choice-Darker'/g' {}  \;
  echo "################################################################"
  echo "Renaming inside the index.theme"
  echo "Arc-$choice-Dark"
  find $HOME"/.themes/Arc-"$choice"-Dark" -name "index.theme" -type f -exec sed -i 's/'Name=Arc-Dark'/'Name=Arc-$choice-Dark'/g' {}  \;
  find $HOME"/.themes/Arc-"$choice"-Dark" -name "index.theme" -type f -exec sed -i 's/'GtkTheme=Arc-Dark'/'GtkTheme=Arc-$choice-Dark'/g' {}  \;
  find $HOME"/.themes/Arc-"$choice"-Dark" -name "index.theme" -type f -exec sed -i 's/'MetacityTheme=Arc-Dark'/'MetacityTheme=Arc-$choice-Dark'/g' {}  \;
  echo "################################################################"
  echo "Renaming inside the index.theme"
  echo "Arc-$choice"
  find $HOME"/.themes/Arc-"$choice -name "index.theme" -type f -exec sed -i 's/'Name=Arc'/'Name=Arc-$choice'/g' {}  \;
  find $HOME"/.themes/Arc-"$choice -name "index.theme" -type f -exec sed -i 's/'GtkTheme=Arc'/'GtkTheme=Arc-$choice'/g' {}  \;
  find $HOME"/.themes/Arc-"$choice -name "index.theme" -type f -exec sed -i 's/'MetacityTheme=Arc'/'MetacityTheme=Arc-$choice'/g' {}  \;
  }

  makearc

  echo "#####################################################################"
  echo "#####################################################################"

  rm -rf /tmp/at/{Arc,Arc-Darker,Arc-Dark}


if grep -q main .git/config; then
	echo "Using main"
		git push -u origin main
fi


END_COMMENT








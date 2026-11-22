#!/bin/bash
# The whole install in menus, like archinstall: disk, base system, then the scripts
# in chroot/ and desktop/ with their packages. The step by step way is README.md + run.sh;
# both read the same scripts, and this menu takes its packages and their comments from them.
# Usage: bash tui.sh [settings]     (as root on the Arch ISO; elsewhere only a preview)
# Settings: the file given, else ~/arch-settings. Save writes your choices back into it
# (comments stay); anything empty gets a US default.

repo=$(dirname "$(realpath "$0")")
conf=${1:-$HOME/arch-settings}
[ -f "$conf" ] && { source "$conf" || exit 1; }
: "${keymap:=us}" "${layout:=erase}" "${luks:=no}" "${kernels:=linux linux-lts}"
: "${packages:=dosfstools nano sudo git}" "${timezone:=America/New_York}" "${locale:=en_US}"
: "${hostname:=archlinux}" "${mirror_countries:=US}"
[[ $autologin == [yY]* ]] && autologin=yes || autologin=no
: "${dots_url:=https://github.com/archlinux-fan/arch-dots}"
grep -q AuthenticAMD /proc/cpuinfo && : "${ucode:=amd-ucode}"
grep -q GenuineIntel /proc/cpuinfo && : "${ucode:=intel-ucode}"
: "${ucode:=none}"
[ -z "$gpu" ] && gpu=$(lspci | grep -iE 'vga|3d|display' | grep -ioE 'amd|intel|nvidia' | sort -fu)
[[ $gpu == *$'\n'* ]] && gpu=        # two makers (laptops): you choose
gpu=${gpu,,}
[ -d /run/archiso ] && iso=1

# Everything Save writes; run.sh reads the same file and ignores what it doesn't know
vars="keymap font timezone locale time_locale hostname username mirror_countries wifi_country
gpu dots_url dots_link private_url private_dir autologin disk layout esp root winesp luks
kernels ucode packages extra pkg_add pkg_skip script_skip"

# Show the cursor again on exit, also after Ctrl+C
trap 'printf "\e[?25h\n"' EXIT

# menu TITLE ITEM...: Up/Down/PgUp/PgDn move, typing jumps to an item that starts with it,
# Enter sets $choice (index) and $picked (text), Esc returns 1. Empty items are gaps.
# check=1: Space toggles the global array sel. info=1: shows desc[i] under the list.
menu() {
    local title=$1 i=${start:-0} top=0 key n x c d buf= rows cols; shift
    local items=("$@")
    while true; do
        read -r rows cols < <(stty size 2>/dev/null); : "${rows:=24}" "${cols:=80}"
        rows=$((rows - (info ? 11 : 5)))
        ((i < top)) && top=$i
        ((i >= top + rows)) && top=$((i - rows + 1))
        # \e[1m bold, \e[7m reversed colours (the selected line), \e[2m dim, \e[0m reset
        printf '\e[?25l\e[H\e[J\e[1m%s\e[0m\n\n' "$title"
        for ((n = top; n < ${#items[@]} && n < top + rows; n++)); do
            x='  '; c=; ((n == i)) && c='\e[7m'
            [ "$check" ] && { ((sel[n])) && x+='[x] ' || x+='[ ] '; }
            [ -z "${items[n]}" ] && x=
            printf "$c%s\e[0m\n" "$x${items[n]:0:cols-8}"
        done
        printf '%*s\n' 40 '' | tr ' ' -
        ((info)) && printf '\e[2m%s\e[0m' "${desc[i]}"
        printf '\e[2m%s\e[0m' "${help:-Up/Down move  ${check:+Space check  }Enter ok  Esc back}"
        IFS= read -rsn1 key || exit; d=0
        [[ $key == [[:alnum:]/_-] ]] || buf=
        case $key in
            $'\e') read -rsn2 -t 0.1 key
                case $key in
                    '[A'|OA) d=-1 ;;
                    '[B'|OB) d=1 ;;
                    '[5') read -rsn1; d=-rows ;;
                    '[6') read -rsn1; d=rows ;;
                    '') return 1 ;;
                esac ;;
            ' ') [ "$check" ] && sel[i]=$((!sel[i])) ;;
            '') choice=$i picked=${items[i]}; return 0 ;;
            *) buf+=$key; jump || { buf=$key; jump; } ;;
        esac
        ((d)) || continue
        ((i += d, i < 0)) && i=0
        ((i >= ${#items[@]})) && i=$((${#items[@]} - 1))
        while [ -z "${items[i]}" ]; do ((i += d < 0 ? -1 : 1)); done
    done
}

# jump: moves menu's i to the next item that starts with buf; one letter again goes on to the next
jump() {
    local n x
    for ((n = ${#buf} > 1 ? 0 : 1; n <= ${#items[@]}; n++)); do
        x=$(((i + n) % ${#items[@]}))
        [[ ${items[x],,} == "${buf,,}"* ]] && { i=$x; return 0; }
    done
    return 1
}

# choose VAR TITLE ITEM...: sets VAR to the picked item; starts on its current value
choose() {
    local var=$1 title=$2 n=0; shift 2
    local items=("$@")
    while ((n < $#)) && [ "${items[n]}" != "${!var}" ]; do ((n++)); done
    start=$((n % $#)) menu "$title" "$@" && printf -v "$var" %s "${items[choice]}"
}

# checklist VAR TITLE ITEM...: Space checks, Enter saves the checked items to VAR
checklist() {
    local var=$1 title=$2 n out=; shift 2
    local items=("$@"); sel=()
    for n in "${!items[@]}"; do has "${!var}" "${items[n]}" && sel[n]=1; done
    start=0 check=1 menu "$title" "$@" || return
    for n in "${!items[@]}"; do ((sel[n])) && out+=" ${items[n]}"; done
    printf -v "$var" %s "${out# }"
}

# input VAR PROMPT: edits VAR on one line; Enter saves, Esc cancels, Backspace deletes
input() {
    local s=${!1} key
    while true; do
        printf '\r\e[K%s%s' "$2" "$s"
        IFS= read -rsn1 key || exit
        case $key in
            $'\e') read -rsn2 -t 0.1 key || return 1 ;;  # Esc alone cancels, arrows are ignored
            $'\x7f'|$'\b') s=${s%?} ;;
            '') printf -v "$1" %s "$s"; return 0 ;;
            *) s+=$key ;;
        esac
    done
}

screen() { printf '\e[H\e[J\e[?25h%s\n\n' "$1"; }
pause() { read -rsp $'\nPress Enter.'; }
row() { printf '%-20s%s' "$1" "$2"; }
online() { ping -c1 -W2 archlinux.org &>/dev/null && net=online || net=offline; }
has() { [[ " $1 " == *" $2 "* ]]; }
# put VAR WORD 0|1: removes WORD from the list in VAR, or adds it
put() { local l=" ${!1} "; l=${l// "$2" / }; (($3)) && l+=" $2"; l=$(echo $l); printf -v "$1" %s "$l"; }
# on NAME DEFAULT: is this package installed, after pkg_add and pkg_skip
on() { if (($2)); then ! has "$pkg_skip" "$1"; else has "$pkg_add" "$1"; fi; }
# line VAR: VAR=value for a settings file, quoted only when needed. ~/ became /root/
# when it was read here; written as ~/ again it means your home for the desktop scripts.
line() {
    local x=${!1}; x=${x/#$HOME\//\~/}
    [[ $x =~ ^[[:alnum:]_./:,@+=~-]*$ ]] && echo "$1=$x" || echo "$1=\"$x\""
}
settings() { local v; for v in $vars; do line "$v"; done; }
locales() { sed -n 's/^#\?\([a-z]\{2,3\}_[A-Z]\{2\}\)\.UTF-8 UTF-8.*/\1/p' /etc/locale.gen | sort -u; }

# parse FILE: names, defs (1 = installed by default) and desc (the comment above) of its
# pacman lines; inside a case block (30-gpu.sh) only the branch for $gpu
pkg_re='^ *(# )?(sudo )?pacman -S --needed ([^ ]+)'
parse() {
    local lines k n l b= d
    mapfile -t lines < "$1"
    names=() defs=() desc=()
    for k in "${!lines[@]}"; do
        l=${lines[k]}
        [[ $l =~ ^\ *([a-z])\*\) ]] && b=${BASH_REMATCH[1]}
        [[ $l == *';;' ]] && b=
        [[ $l =~ $pkg_re ]] && [[ -z $b || $b == "${gpu:0:1}" ]] || continue
        names+=("${BASH_REMATCH[3]}")
        [ -z "${BASH_REMATCH[1]}" ] && defs+=(1) || defs+=(0)
        # The comment above, skipping the package lines that share it
        d= n=$k
        while ((n-- > 0)); do
            l=${lines[n]}
            if [[ $l == *'pacman -S --needed'* ]]; then [ -z "$d" ] && continue; break; fi
            [[ $l =~ ^\ *#\ [^[] && $l != *'Not installed by default'* ]] || break
            d="${l#*# }"$'\n'"$d"
        done
        desc+=("$d")
    done
}

# Edited copy of a script for Install: pkg_skip lines commented out, pkg_add lines
# uncommented (with the "# [" lines right below them), --noconfirm on every pacman line
edit='
/^ *(# )?(sudo )?pacman -S --needed / {
    n = $0; sub(/.*--needed /, "", n); sub(/ .*/, "", n); u = 0
    if (/^ *#/ && index(add, " " n " ")) { sub(/# /, ""); u = 1 }
    else if (!/^ *#/ && index(skip, " " n " ")) sub(/[^ ]/, "# &")
    if (!/^ *#/) sub(/--needed/, "--needed --noconfirm")
    print; next
}
u && /^ *# \[/ { sub(/# /, ""); print; next }
{ u = 0; print }'

# tally FILE...: how many of their packages get installed
tally() {
    local f n p=0 t=0
    for f; do parse "$f"; for n in "${!names[@]}"; do ((t++)); on "${names[n]}" "${defs[n]}" && ((p++)); done; done
    ((t)) && echo "$p of $t packages"
}

# active DIR: its scripts that are not turned off
active() { local f; for f in "$repo/$1"/*.sh; do has "$script_skip" "${f#$repo/}" || echo "$f"; done; }

# scripts DIR TITLE: Space turns a script on or off, Enter shows its packages
scripts() {
    local f n c pos=0 files=("$repo/$1"/*.sh) items
    while true; do
        items=() sel=()
        for n in "${!files[@]}"; do
            f=${files[n]#$repo/}
            has "$script_skip" "$f" || sel[n]=1
            items+=("$(row "${f#*/}" "$(tally "${files[n]}")")")
        done
        start=$pos check=1 help='Up/Down move  Space on/off  Enter packages  Esc back' menu "$2" "${items[@]}"
        c=$?
        for n in "${!files[@]}"; do put script_skip "${files[n]#$repo/}" $((!sel[n])); done
        ((c)) && return
        pos=$choice; packages "${files[choice]}"
    done
}

# packages FILE: Space checks a package; under the list the comment from the script
packages() {
    local n; parse "$1"; sel=()
    ((${#names[@]})) || return
    for n in "${!names[@]}"; do on "${names[n]}" "${defs[n]}" && sel[n]=1; done
    start=0 check=1 info=1 menu "${1#$repo/}" "${names[@]}" || return
    for n in "${!names[@]}"; do
        put pkg_add "${names[n]}" $((sel[n] && !defs[n]))
        put pkg_skip "${names[n]}" $((!sel[n] && defs[n]))
    done
}

network() {
    menu "Network: $net. A cable works by itself." "Check again" "Connect to Wi-Fi" || return
    if ((choice == 1)); then
        local dev ssid
        dev=$(ls -d /sys/class/net/*/wireless 2>/dev/null | head -1 | cut -d/ -f5)
        screen "Wi-Fi card: ${dev:-none found}"
        if [ "$iso" ] && [ "$dev" ]; then
            iwctl station "$dev" scan; sleep 2
            iwctl station "$dev" get-networks
            input ssid "Network name (Esc = cancel): " && [ "$ssid" ] && iwctl station "$dev" connect "$ssid"
        else
            echo "Wi-Fi is set up only on the Arch ISO."; pause
        fi
    fi
    online
}

pick_disk() {
    local disks
    mapfile -t disks < <(lsblk -dnpo NAME,SIZE,MODEL -e 7,11 | grep -v zram)
    menu "Disk to install on" "${disks[@]}" && disk=${disks[choice]%% *}
}

disk_layout() {
    menu "Disk layout" "Erase whole disk: 1G EFI + root" "Dual boot: keep Windows, use its free space" || return
    ((choice == 0)) && { layout=erase; return; }
    [ "$disk" ] || { screen "Choose a disk first."; pause; return; }
    screen "cfdisk opens. Delete nothing. In the free space: New 1G, Type EFI System;
New (Enter = the rest), Type Linux root (x86-64). Then Write, yes, Quit."
    pause
    [ "$iso" ] && cfdisk "$disk"
    local parts
    mapfile -t parts < <(lsblk -lnpo NAME,SIZE,FSTYPE,PARTTYPENAME "$disk" | tail -n +2)
    menu "Your new EFI partition (1G, gets erased)" "${parts[@]}" && esp=${parts[choice]%% *} &&
    menu "Your new root partition (gets erased)" "${parts[@]}" && root=${parts[choice]%% *} &&
    menu "The Windows EFI partition (about 100M, vfat): its boot files are copied" "${parts[@]}" none &&
    winesp=${parts[choice]%% *} && layout=dualboot
}

# mirrors: the countries with Arch mirrors, from reflector (needs internet), checked with
# Space and saved as codes (SI,ES); without the list you type them
mirrors() {
    local l n m out= items=() codes=() lines first
    screen "Mirror countries: loading the list ..."
    mapfile -t lines < <(reflector --list-countries 2>/dev/null | tail -n +3)
    if ((${#lines[@]} == 0)); then
        screen "Mirror countries near you, e.g. US,CA (empty = all). Enter saves, Esc cancels."
        input mirror_countries "> "; return
    fi
    m=",${mirror_countries,,},"; m=${m//, /,}; sel=()
    for l in "${lines[@]}"; do
        [[ $l =~ ^(.*[^ ])\ +([A-Z]{2})\ +([0-9]+)$ ]] || continue
        [[ $m == *",${BASH_REMATCH[2],,},"* || $m == *",${BASH_REMATCH[1],,},"* ]] && sel[${#codes[@]}]=1
        codes+=("${BASH_REMATCH[2]}")
        # printf pads by bytes and é is two, so pad by the letter count ${#l}
        l=${BASH_REMATCH[1]}
        items+=("$l$(printf '%*s' $((27 - ${#l})) "${BASH_REMATCH[3]}")")
    done
    first=("${!sel[@]}")
    start=${first[0]:-0} check=1 menu "Mirror countries near you; the number is how many mirrors (none = all)" "${items[@]}" || return
    for n in "${!codes[@]}"; do ((sel[n])) && out+=,${codes[n]}; done
    mirror_countries=${out#,}
}

user() {
    screen "Your user name: lowercase letters, digits, - and _. Enter saves, Esc cancels."
    input username "> " || return
    [[ $username =~ ^[a-z_][a-z0-9_-]*$ ]] || { username=; printf '\nNot valid.'; pause; }
}

dotfiles() {
    menu "Dotfiles: the settings of your desktop, copied into your home" \
        "arch-dots (the desktop in the pictures)" "None" "Your own repo" || return
    case $choice in
        0) dots_url=https://github.com/archlinux-fan/arch-dots ;;
        1) dots_url=n ;;
        2) screen "Dotfiles repo URL. Enter saves, Esc cancels."; input dots_url "> " ;;
    esac
}

# save: a line already in the file gets the new value and keeps its comment;
# other values that are set go to the end
save() {
    screen "Save to a settings file; run.sh reads it too. Enter saves, Esc cancels."
    input conf "File: " || return
    local v n re lines=("# arch-install settings: bash tui.sh <this file>, or ./run.sh chroot|desktop <this file>")
    [ -f "$conf" ] && mapfile -t lines < "$conf"
    for v in $vars; do
        re="^$v=(\"[^\"]*\"|'[^']*'|[^ #]*)(.*)"
        for n in "${!lines[@]}"; do
            [[ ${lines[n]} =~ $re ]] && { lines[n]=$(line "$v")${BASH_REMATCH[2]}; continue 2; }
        done
        [ -n "${!v}" ] && lines+=("$(line "$v")")
    done
    printf '%s\n' "${lines[@]}" > "$conf" && { printf '\nSaved.'; pause; }
}

run() {
    printf '\n\e[1m# %s\e[0m\n' "$1"
    eval "$1" && return
    echo "Failed. Fix it and go on by hand with the README."; pause; return 1
}

install_all() {
    local v dev c f cmds=() gone="everything on $disk" t=/mnt/var/tmp/tui
    for v in disk kernels timezone hostname username; do
        [ -n "${!v}" ] || { screen "Choose the $v first."; pause; return; }
    done
    [ "$net" = online ] || [ -z "$iso" ] || { screen "No internet: see Network."; pause; return; }
    if [ "$layout" = erase ]; then
        [[ $disk == *[0-9] ]] && esp=${disk}p1 root=${disk}p2 || esp=${disk}1 root=${disk}2
        cmds+=("printf 'label: gpt\nsize=1G, type=U\ntype=4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709\n' | sfdisk --wipe always $disk"
            "udevadm settle")
    elif [ -z "$esp" ] || [ -z "$root" ]; then
        screen "Dual boot: choose the partitions in Disk layout first."; pause; return
    else
        gone="$esp and $root"
    fi
    dev=$root
    [ "$luks" = yes ] && { cmds+=("cryptsetup luksFormat $root" "cryptsetup open $root root"); dev=/dev/mapper/root; }
    cmds+=("mkfs.ext4 $dev" "mount $dev /mnt"
        "mkfs.fat -F 32 $esp" "mount --mkdir -o fmask=0077,dmask=0077 $esp /mnt/boot"
        "pacstrap -K /mnt $(echo base $kernels linux-firmware ${ucode#none} $packages $extra)"
        "genfstab -U /mnt >> /mnt/etc/fstab")
    [ "$layout" = dualboot ] && [ "$winesp" ] && cmds+=("mount --mkdir $winesp /win"
        "mkdir -p /mnt/boot/EFI" "cp -r /win/EFI/Microsoft /mnt/boot/EFI/" "umount /win")

    screen "Install runs these commands:"
    printf '  %s\n' "${cmds[@]}"
    printf '\nThen inside the new system, as root:\n  %s\n' "$(echo $(active chroot | sed 's|.*/||'))"
    printf 'And as %s:\n  %s\n' "$username" "$(echo $(active desktop | sed 's|.*/||'))"
    [ "$iso" ] || { printf '\nThis is not the Arch ISO, so nothing runs.\n'; pause; return; }
    printf '\nErased: %s. Passwords are asked on the way.\n' "$gone"
    read -rp "Type yes to start: " c
    [ "$c" = yes ] || return
    for c in "${cmds[@]}"; do run "$c" || return; done

    # The scripts go to /root/arch-install (30-user.sh copies them to your home),
    # the settings and the edited copies to /var/tmp/tui; both are removed at the end.
    mkdir -p "$t" && cp -r "$repo" /mnt/root/arch-install && settings > "$t/settings" || return
    for f in $(active chroot) $(active desktop); do
        v=${f#$repo/}
        awk -v add=" $pkg_add " -v skip=" $pkg_skip " "$edit" "$f" > "$t/${v/\//-}"
    done
    for f in "$t"/chroot-*; do
        printf '\n\e[1m# %s\e[0m\n' "${f##*/}"
        arch-chroot /mnt bash -c "set -a; . /var/tmp/tui/settings; set +a
            cd /root/arch-install/chroot && bash /var/tmp/tui/${f##*/}"
    done
    # Desktop scripts run as your user. sudo needs no password until they are done,
    # dbus-run-session lets gsettings save the GTK theme without a running desktop.
    printf '%s ALL=(ALL:ALL) NOPASSWD: ALL\n' "$username" > /mnt/etc/sudoers.d/99-tui
    chmod 440 /mnt/etc/sudoers.d/99-tui
    for f in "$t"/desktop-*; do
        printf '\n\e[1m# %s\e[0m\n' "${f##*/}"
        arch-chroot /mnt runuser -u "$username" -- bash -c "cd; set -a; . /var/tmp/tui/settings; set +a
            dbus-run-session bash /var/tmp/tui/${f##*/}"
    done
    rm -rf /mnt/etc/sudoers.d/99-tui "$t" /mnt/root/arch-install
    pause
    menu "Installed. Take the USB stick out when the screen goes dark." "Reboot now" \
        "Exit to the shell (the new system stays mounted at /mnt)" &&
        ((choice == 0)) && umount -R /mnt && reboot
    exit
}

online
[ "$iso" ] && { loadkeys "$keymap"; setfont $font; }
title="Arch Linux install"
[ "$iso" ] || title+=" (preview: not the Arch ISO, nothing runs)"
while true; do
    [ "$layout" = erase ] && lay="Erase whole disk: 1G EFI + root" || lay="Dual boot: EFI $esp, root $root"
    dots=${dots_url##*/}; [[ $dots_url == [nN]* ]] && dots=none
    start=$main menu "$title" \
        "$(row 'Keyboard layout' "$keymap")" \
        "$(row 'Console font' "${font:-default}")" \
        "$(row Network "$net")" \
        "$(row Disk "${disk:-choose one} $(lsblk -dno SIZE "$disk" 2>/dev/null)")" \
        "$(row 'Disk layout' "$lay")" \
        "$(row 'Encryption (LUKS2)' "$luks")" \
        "$(row Kernels "$kernels")" \
        "$(row Microcode "$ucode")" \
        "$(row 'Base packages' "$packages")" \
        "$(row 'More packages' "${extra:-none}")" \
        "" \
        "$(row 'Time zone' "$timezone")" \
        "$(row Locale "$locale")" \
        "$(row Hostname "$hostname")" \
        "$(row User "${username:-choose one}")" \
        "$(row Mirrors "${mirror_countries:-all}")" \
        "" \
        "$(row 'System (chroot)' "$(active chroot | wc -l) scripts, $(tally $(active chroot))")" \
        "$(row Desktop "$(active desktop | wc -l) scripts, $(tally $(active desktop))")" \
        "$(row Graphics "${gpu:-choose one}")" \
        "$(row Dotfiles "$dots")" \
        "$(row Autologin "$autologin")" \
        "" \
        "$(row 'Save settings' "$conf")" \
        Install Abort || break
    main=$choice
    case $picked in
        'Keyboard layout'*) choose keymap "Keyboard layout (type to search)" $(localectl list-keymaps) &&
                            [ "$iso" ] && loadkeys "$keymap" ;;
        'Console font'*) choose font "Console font (ter-132b = big letters)" default ter-124b ter-128b ter-132b
                         [ "$font" = default ] && font=
                         [ "$iso" ] && setfont $font ;;
        Network*) network ;;
        'Disk layout'*) disk_layout ;;
        Disk*) pick_disk ;;
        Encryption*) choose luks "Encrypt the disk (LUKS2): a passphrase at every boot" no yes ;;
        Kernels*) checklist kernels "Kernels: lts = older, stable; hardened = more secure; zen = tuned for desktop" \
                      linux linux-lts linux-hardened linux-zen ;;
        Microcode*) choose ucode "Processor fixes (microcode)" amd-ucode intel-ucode none ;;
        'Base packages'*) checklist packages "Base packages" dosfstools nano sudo git ;;
        'More packages'*) screen "More packages for the base system, separated by spaces. Enter saves, Esc cancels."
                          input extra "> " ;;
        'Time zone'*) choose timezone "Time zone (type to search, e.g. europe/b)" $(timedatectl list-timezones) ;;
        Locale*) choose locale "Locale: numbers, units and sorting; messages stay English" $(locales) ;;
        Hostname*) screen "Hostname: the name of this computer on your network. Enter saves, Esc cancels."
                   input hostname "> " ;;
        User*) user ;;
        Mirrors*) mirrors ;;
        System*) scripts chroot "System: runs as root inside the new system" ;;
        Desktop*) scripts desktop "Desktop: runs as your user" ;;
        Graphics*) choose gpu "Graphics driver" amd intel nvidia ;;
        Dotfiles*) dotfiles ;;
        Autologin*) choose autologin "Log in automatically on TTY1 (makes sense with LUKS)" no yes ;;
        Save*) save ;;
        Install) install_all ;;
        Abort) break ;;
    esac
done

# How the scripts work

[← Back](../README.md)

## Running them

The scripts are plain text files with commands, the same you would type by hand. Open one with
`nano` or on GitHub and read it before you run it: a comment above every command says what it does.

`run.sh <folder>` runs every script in that folder in order and asks `[Y/n]` before each one.
Enter or `y` runs it, `n` skips it. The number in a name sets the order.

```bash
./run.sh chroot     # as root, inside arch-chroot, before the first boot
./run.sh desktop    # as your user, after the first boot
```

Optional scripts are never run automatically. Start them when you want: `bash ~/arch-install/optional/zram.sh` ([list](extras.md#optional-scripts)).

Inside a script every package has its own line, so pacman asks for each one:

```bash
# NetworkManager connects to Wi-Fi and Ethernet and reconnects by itself.
pacman -S --needed networkmanager && systemctl enable NetworkManager
```

- `pacman -S` installs a package, `--needed` skips packages you already have, so running a script twice is safe.
- A service is a program that runs in the background (network, Bluetooth, firewall). `systemctl enable` starts it
  at every boot. It sits on the same line after `&&`: say no to the package and the service is skipped too.
- Lines that start with `#` don't run. Packages that are not installed by default are commented out with their
  explanation; remove the `#` to add one, or just copy the line into a terminal.

## Saved answers

Some scripts ask for your time zone, language, keyboard, user name and so on. On your first install just answer them.
For the next computer, save the answers in a file, see [settings.example](../settings.example),
and pass it as the second argument:

```bash
./run.sh chroot /path/to/settings
```

Anything missing from the file is asked as usual. A few settings exist only in the file and are never asked:
a separate locale for dates (`time_locale`), the console font, linking your dotfiles with stow (`dots_link`)
and a private repo. Where to keep the file: [your own private repo](private-repo.md).

## chroot/

Run as root from the USB stick, inside the new system (`arch-chroot`), before its first boot.

| Script | What it does |
|---|---|
| `10-locale.sh` | time zone, language, console keyboard |
| `20-hostname.sh` | name of the computer |
| `30-user.sh` | root password, your user, sudo for the wheel group, a copy of these scripts in your home |
| `40-boot.sh` | systemd-boot and boot entries; detects LUKS and adds the unlock step |
| `50-system.sh` | pacman colors, fastest mirrors (reflector), weekly SSD trim |
| `60-network.sh` | NetworkManager, firewall; Wi-Fi country rules (not installed by default) |

## desktop/

Run as your user after the first boot; `sudo` asks your password.

| Script | What it does |
|---|---|
| `10-shell.sh` | git, btop, jq, 7zip; the shell stays bash |
| `20-audio-bluetooth.sh` | PipeWire, volume control, Bluetooth |
| `30-gpu.sh` | AMD, Intel or NVIDIA drivers; finds which one you have |
| `40-mango.sh` | mango, waybar, mako, rofi, lock screen, idle, wallpaper, screenshots, fonts |
| `50-apps.sh` | foot, Thunar, Firefox and its system rules, lite-xl, mousepad, mpv, ristretto, xpdf, transmission |
| `60-aur.sh` | yay, for AUR packages |
| `70-dotfiles.sh` | copies your dotfiles into `~` (arch-dots by default) and applies their GTK theme, makes the Firefox profiles (`firefox-profiles`, if the dotfiles have it), optional autologin; private repo and stow only from the settings file |

## optional/

Never run by `run.sh`: zsh, printing, zram, Steam and more. What each one does: [Extras](extras.md#optional-scripts).

## Make it yours

Fork the repo, comment out what you don't want, uncomment what you do. Keep one package per line
and the comment above it, and the scripts stay easy to read for the next person.

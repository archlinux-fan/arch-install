# How the scripts work

[← Back](../README.md)

## Running them

`run.sh <folder>` runs every script in that folder in order and asks `[Y/n]` before each one.

```bash
./run.sh chroot     # as root, inside arch-chroot, before the first boot
./run.sh desktop    # as your user, after the first boot
```

Optional scripts are never run automatically. Start them when you want: `bash optional/zram.sh`.

Inside a script every package has its own line, so pacman asks for each one:

```bash
# NetworkManager connects to Wi-Fi and Ethernet and reconnects by itself.
pacman -S --needed networkmanager && systemctl enable NetworkManager
```

- `--needed` skips packages you already have, so running a script twice is safe.
- A service is enabled on the same line after `&&`: say no to the package and the service is skipped too.
- Packages that are not installed by default are commented out with their explanation. Remove the `#` to add one.

## Saved answers

Some scripts ask for your time zone, language, keyboard, user name and so on. Save the answers in a file,
see [settings.example](../settings.example), and pass it as the second argument:

```bash
./run.sh chroot /path/to/settings
```

Anything missing from the file is asked as usual. Where to keep the file: [your own private repo](private-repo.md).

## chroot/

| Script | What it does |
|---|---|
| `10-locale.sh` | time zone, language, console keyboard and font |
| `20-hostname.sh` | name of the computer |
| `30-user.sh` | root password, your user, sudo for the wheel group |
| `40-boot.sh` | systemd-boot and boot entries; detects LUKS and adds the unlock step |
| `50-system.sh` | pacman colors, fastest mirrors (reflector), weekly SSD trim |
| `60-network.sh` | NetworkManager, Wi-Fi country, firewall |

## desktop/

| Script | What it does |
|---|---|
| `10-shell.sh` | zsh with suggestions and highlighting, fzf, git, stow, btop, archive tools |
| `20-audio-bluetooth.sh` | PipeWire, volume control, Bluetooth |
| `30-gpu.sh` | AMD, Intel or NVIDIA drivers |
| `40-hyprland.sh` | Hyprland, waybar, mako, rofi, lock screen, idle, wallpaper, screenshots, fonts |
| `50-apps.sh` | foot, Thunar, lite-xl, mousepad, mpv, ristretto, xpdf, transmission |
| `60-aur.sh` | yay and Brave Origin, the only AUR package |
| `70-dotfiles.sh` | clones your dotfiles and private repo, links them with stow, optional autologin |

## optional/

| Script | What it does |
|---|---|
| `printing.sh` | CUPS, adds a network printer by IP, no drivers needed |
| `zram.sh` | compressed swap in RAM |
| `syncthing.sh` | sync folders with your phone and other computers |
| `nfs.sh` | share folders with other Linux machines |
| `games.sh` | multilib repo, 32-bit drivers, Steam |

## Make it yours

Fork the repo, comment out what you don't want, uncomment what you do. Keep one package per line
and the comment above it, and the scripts stay easy to read for the next person.

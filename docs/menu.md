# Install with menus

[← Back](../README.md)

`tui.sh` is the other way through the install: a menu, like the installer of Windows.
You make your choices first, with the arrow keys. Then **Install** does steps 2 to 5 of the
[install page](../README.md) by itself, the desktop included.
It runs the same scripts as the step by step way, so you get the same system.

| | Step by step (`run.sh`) | Menu (`tui.sh`) |
|---|---|---|
| You type | every command from the install page | two commands that start the menu |
| Packages | pacman asks `[Y/n]` for each one | you check them in a list |
| Questions | asked while the scripts run | all in the menu, before anything happens |
| Desktop | installed after the first boot | installed before; it's there the first time you log in |

## Start it

Do [Before you start](../README.md#before-you-start) and [step 1](../README.md#1-boot-the-usb-stick) of the install page:
boot the USB stick, set your keyboard and check that the internet works. Then:

```bash
curl -L https://github.com/archlinux-fan/arch-install/archive/main.tar.gz | tar xz
bash arch-install-main/tui.sh
```

`curl` downloads the scripts as one packed file (`.tar.gz`, like a `.zip`), `tar xz` unpacks it into the
folder `arch-install-main`, and `bash` starts the menu in it.

Want to look first? On a computer that already runs Linux, `bash tui.sh` shows the same menu as a preview.
Nothing is changed there, not even with Install.

## Keys

| Key | What it does |
|---|---|
| ↑ ↓ | move; PgUp and PgDn move a page |
| letters | jump: in Time zone, `europe/b` goes to Europe/Berlin |
| Space | check or uncheck, in lists with `[x]` |
| Enter | pick; in a list with `[x]` it saves the list |
| Esc | back; a changed value stays as it was |

## The menu

Every line shows its value. The values start as for someone in the US: change what isn't yours.

| Line | What it is |
|---|---|
| Keyboard layout | the keys of your keyboard: `uk`, `de`, `fr` ... Used right away, later in the console and for the disk passphrase. |
| Console font | `ter-132b` for bigger letters if the text is tiny. |
| Network | `online` means the internet works. A cable works by itself; for Wi-Fi pick Connect to Wi-Fi, type its name and password. |
| Disk | where Arch goes: `nvme0n1` is an NVMe SSD, `sda` a SATA disk. The size helps you tell them apart. Not the USB stick! |
| Disk layout | **Erase whole disk** deletes everything on it. **Dual boot** keeps Windows, see below. |
| Encryption (LUKS2) | `yes` locks the disk with a passphrase you type at every boot. Good for a laptop. Forget it and your files are gone. |
| Kernels | the core of the system. `linux` is the newest, `linux-lts` an older one to pick in the boot menu if the new one has a problem. |
| Microcode | fixes for your processor (AMD or Intel), found by itself. |
| Base packages | the few programs installed with the system: `nano` (a text editor), `sudo`, `git`. |
| More packages | names of more packages, if you already know you want them. |
| Time zone | type to search, e.g. `america/n` for America/New_York. |
| Locale | how numbers, dates and units are written: `en_US`, `de_DE` ... Program messages stay English. |
| Hostname | a name for this computer on your network. |
| User | your login name: lowercase letters, no spaces. |
| Mirrors | the countries of the download servers: pick yours and the ones next to it. The number is how many servers a country has. |
| System (chroot) | the scripts that set up the system: language, boot menu, network, firewall. |
| Desktop | the scripts for the desktop and the programs. Space turns a whole script off; Enter shows its packages, and the line under the list says what each one is. |
| Graphics | the driver for your graphics chip, found by itself. |
| Dotfiles | the settings of the desktop: `arch-dots` is the desktop in the pictures. |
| Autologin | `yes` skips the login on the console. Makes sense with encryption, where you already typed a passphrase. |
| Save settings | writes your choices to a file, for the next install. See below. |
| Install | shows every command, then asks before it does anything. |
| Abort | quits. Nothing was changed. |

<details markdown="1">
<summary>Dual boot with Windows: skip this if Arch will be the only system</summary>

Free up space in Windows first: [Before you start](../README.md#before-you-start).
In the menu pick your disk, then Disk layout → **Dual boot**. cfdisk opens, a menu for partitions: arrow keys move, Enter picks.
Delete nothing. In the free space:

1. **New** → type `1G` → **Type** → **EFI System**.
2. **New** → Enter (the rest of the space) → **Type** → **Linux root (x86-64)**.
3. **Write** → type `yes` → **Quit**.

Then pick from the lists: your new 1G EFI partition, your new root partition, and the Windows EFI partition
(about 100M, `vfat`). Its boot files are copied, so the boot menu shows Windows too.

</details>

## Install

Pick **Install**. The menu lists every command it will run, and the scripts after them.
Read the list: what it names is erased. Type `yes` and press Enter. Then you are asked for:

- with encryption: `YES` in capitals, then your passphrase twice;
- the root password: root is the administrator, you need this password only to repair a broken system;
- your own password, for logging in and for `sudo`.

Password prompts show nothing while you type, not even dots. That's normal.
Then it downloads and installs; that takes a while. At the end pick **Reboot now**
and take the USB stick out when the screen goes dark.

## After the first boot

Pick Arch Linux in the boot menu, type the passphrase if you encrypted the disk and log in with your user name.
mango starts by itself. First keys (Super is the Windows key): **Super+Return** terminal, **Super+Space** app menu,
**Super+Q** closes a window. More keys: [arch-dots](https://github.com/archlinux-fan/arch-dots#keys).

Wi-Fi from the USB stick isn't remembered: open a terminal and type `nmtui` (Activate a connection → your Wi-Fi → password).
A cable works by itself. The scripts are in `~/arch-install` for later: [extras](extras.md), [tips](tips.md).

## Next time: save your choices

**Save settings** writes everything into a file, the same kind `run.sh` reads ([settings.example](../settings.example)).
Next time start the menu with that file and everything is filled in: `bash arch-install-main/tui.sh <file>`.

On the USB stick the file lands in `/root/arch-settings`, in memory, and is gone after a restart.
To keep it, use [your own private repo](private-repo.md): prepare the file on your running computer
with `bash ~/arch-install/tui.sh ~/private/install/settings` (the preview), pick, Save, commit and push.
Save puts the new values into the file and keeps its comments. Packages you turned off go to `pkg_skip`,
the ones you added to `pkg_add`, scripts you turned off to `script_skip`.

## How it works

The menu has no package list of its own: it reads the scripts in `chroot/` and `desktop/`.
A `pacman` line is a package that is installed by default, a line starting with `#` one that isn't,
and the comment above it is the text under the list. On Install it makes a copy of each script with your choices,
runs it and deletes it; the scripts themselves never change. More: [how the scripts work](scripts.md).

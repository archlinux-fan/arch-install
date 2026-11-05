# Extras

[← Back](../README.md)

For later, once the desktop works. None of it is needed.

## zsh instead of bash

The shell runs the commands you type in the terminal. Yours is bash, the one nearly every guide uses.
zsh is typed the same way and adds:

- a grey suggestion from your history while you type; → (right arrow) takes it
- colors while you type: a command turns green when it exists, red when it's mistyped
- Ctrl+R searches your history, Ctrl+T finds files

With [arch-dots](https://github.com/archlinux-fan/arch-dots) its settings are already there. Install it:

```bash
bash ~/arch-install/optional/zsh.sh
```

It makes zsh your shell (asks your password) and asks whether to delete bash's settings and history.
Keep them if you might go back: without `~/.bash_profile`, mango doesn't start by itself in bash.
zsh is used from the next login, so reboot.

Switch by hand, also from the next login:

```bash
chsh -s /usr/bin/zsh      # zsh
chsh -s /bin/bash         # back to bash
```

## Optional scripts

Never run by `run.sh`. Start one as your user whenever you want: `bash ~/arch-install/optional/<name>.sh`.

| Script | What it does |
|---|---|
| `zsh.sh` | zsh with suggestions and colors as your shell |
| `printing.sh` | CUPS, adds a network printer by IP, no drivers needed |
| `zram.sh` | compressed swap in RAM |
| `syncthing.sh` | sync folders with your phone and other computers |
| `nfs.sh` | share folders with other Linux machines |
| `games.sh` | multilib repo, Vulkan and 32-bit drivers, Steam |

## Your settings in git

The install copies the arch-dots settings into your home folder: plain files you change as you like.
To keep your own changes in a git repo instead, with a second computer set up the same way in minutes:
[your own private repo](private-repo.md). There `dots_link=y` links your dotfiles with stow instead of copying them.

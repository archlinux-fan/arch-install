# Your own private repo

[← Back](../README.md)

Your setup can live in three git repos:

| Repo | Visibility | What's in it |
|---|---|---|
| this one | public | how to install |
| dotfiles | public or private | how it looks and works: Hyprland, waybar, themes, zsh ... |
| private | **private** | what is only yours: install answers, ssh config, git name and e-mail, monitor layout |

Dotfiles can be shared, with family or with the world. Everything that names you, your machines or your
network goes to the private repo, on a server only you can read.

## Layout

The private repo mirrors your home folder, like the dotfiles repo, plus files that stay out of `~`:

```
private/
├── .stow-local-ignore      # what stow must not link into ~
├── install/settings        # your answers for run.sh, see settings.example
├── .ssh/config             # hosts and user names; never the keys
├── .config/git/config      # your name and e-mail for commits
└── .config/hypr/local.lua  # e.g. monitors, if your dotfiles load such a file
```

`.stow-local-ignore`:

```
\.git
^/install
^/README.*
^/\.stow-local-ignore
```

This file replaces stow's built-in ignore list, so `\.git` must be repeated here.

A file belongs to one repo only. If both have `~/.config/git/config`, stow refuses to link it.
Never commit passwords or private keys, not even to a private repo.

## Create it

On your git server (Gitea, GitHub ...) create an empty repo and mark it **private**. Then:

```bash
mkdir -p ~/private/install && cd ~/private
cp ~/arch-install/settings.example install/settings     # then fill it in
git init -b main && git add -A && git commit -m "My private settings"
git remote add origin <your-private-repo-url>
git push -u origin main
```

## Use it during the install

On a fresh system you have no SSH key yet, so clone over HTTPS with your user name and a password or access token.

In the chroot:

```bash
git clone https://your-git-server/you/private.git /root/private
/root/arch-install/run.sh chroot /root/private/install/settings
```

After the first boot, clone it straight to `~/.private`. `desktop/70-dotfiles.sh` finds it there and links it with stow:

```bash
git clone https://your-git-server/you/private.git ~/.private
~/arch-install/run.sh desktop ~/.private/install/settings
sudo rm -rf /root/private
```

## After the install

Create a new SSH key for this computer and add the public part to your git server:

```bash
ssh-keygen -t ed25519
cat ~/.ssh/id_ed25519.pub
git -C ~/.private remote set-url origin <ssh-url>
```

Change something in `~` that is linked to the repo and it is already changed in the repo: commit and push.

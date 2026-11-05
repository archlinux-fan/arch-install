#!/bin/bash
# zsh instead of bash, for when you're at home on the command line. Commands are typed
# the same way; zsh adds suggestions from your history and colors for typos.
# The dotfiles (arch-dots) have its settings: ~/.zshenv and ~/.config/zsh.

sudo pacman -S --needed zsh
# Suggests the rest of a command from your history as you type (grey text, → accepts).
sudo pacman -S --needed zsh-autosuggestions
# Colors commands while you type: green = exists, red = typo.
sudo pacman -S --needed zsh-syntax-highlighting
# Fuzzy finder: Ctrl+R searches your history, Ctrl+T finds files.
sudo pacman -S --needed fzf

# zsh becomes your shell from the next login; chsh asks your password.
# Back to bash any time: chsh -s /bin/bash
chsh -s /usr/bin/zsh

# bash's settings and history aren't used any more. Keep them if you might go back:
# without ~/.bash_profile mango doesn't start by itself in bash.
read -rp "Delete bash's settings and history (~/.bash_profile, ~/.bashrc, ~/.bash_logout, ~/.bash_history)? [y/N] " answer
[[ $answer == [yY]* ]] && rm -f ~/.bash_profile ~/.bashrc ~/.bash_logout ~/.bash_history

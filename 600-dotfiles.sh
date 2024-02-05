#!/bin/bash

##################################################################################################################
# I got inspiration from:
# Author    : Erik Dubois 
# Github    : https://github.com/erikdubois
##################################################################################################################


# Here's a guide to setting up automatic synchronization of your dotfiles folder with GitHub on Arch Linux:

1. Install Git:
sudo pacman -S git  
2. Create a GitHub repository:

Go to GitHub and create a new repository specifically for your dotfiles.
Keep it private if you prefer not to share your configuration files publicly.


3. Initialize a local Git repository in your dotfiles folder:

Create a folder for your dotfiles if it doesn't exist (e.g., ~/.dotfiles).
Move your existing dotfiles into this folder.
Navigate to the folder in your terminal and initialize Git:

cd ~/.dotfiles
git init --bare

# do this before the next command with the token
git remote add origin https://github.com/archlinux-fan/dotfiles.git

# git remote set-url origin https://<personal access token>@github.com/<username>/<repository>.git
git remote set-url origin https://<personal access token>@github.com/archlinux-fan/dotfiles.git

Create an alias in your bash configuration file ~/.bashrc:

Add the following line, replacing dotfiles with your preferred alias name:
alias dots='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'


In your terminal, run the following command to apply the changes so that command is recognised by the terminal or just restart the terminal
source ~/.bashrc  


also run the command:
dots config status.showUntrackedFiles no

Now, whenever you want to use Git commands with your dotfiles repository, you can use the dotfiles alias instead of typing the full command each time:

Bash
# To see status of tracked files:
dots status

# To add a file to the repository:
dots add .bashrc

# To add a directory to the repository:
dots add ~/.config/audacious/

# To commit changes:
dots commit -m "Updated bash settings"

# To push changes to a remote repository:
dots push origin master

Key points:

The alias doesn't store the command within the Git repository itself, but it provides a convenient way to access it from anywhere in your terminal.
The alias is specific to your shell environment. If you use different shells, you'll need to set up the alias in each one.
Remember to replace dots with your preferred alias name.


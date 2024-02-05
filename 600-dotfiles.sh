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
git init  

4. Add a remote to connect to your GitHub repository:
git remote add origin https://github.com/<your-username>/<your-dotfiles-repo>.git


5. Add files to the repository:
git add .  


6. Commit your changes:
git commit -m "Initial commit of dotfiles"  


7. Push your dotfiles to GitHub:
git push -u origin main  


8. Set up a post-commit hook for automatic synchronization:

Create a file named .git/hooks/post-commit in your dotfiles folder.
Add the following content to the file:
Bash
#!/bin/sh
git push origin main  
Make the file executable:
Bash
chmod +x .git/hooks/post-commit  
Now, whenever you commit changes to your dotfiles, they will automatically be pushed to GitHub, ensuring synchronization.

Additional notes:

To manage symlinks effectively, consider using a tool like stow or a custom script.
For more advanced strategies and configuration options, refer to the Arch Wiki's Dotfiles page: https://wiki.archlinux.org/title/Dotfiles: https://wiki.archlinux.org/title/Dotfiles
profilna slika
ok. But I would only like to monitor a few pre specified folders in /home/.config folder (like /home/.config/xfce) so that any changes made in that folder are automatically pushed to github. I use bash by the way. So how can I specify that in git

Here's how to monitor and sync specific folders within /home/.config with GitHub, using Bash and Git:

Create a dedicated Git repository:

Create a new repository in a separate location, not within /home/.config. This avoids tracking the entire .config folder.
Example: mkdir ~/dotfiles-config
Initialize Git: cd ~/dotfiles-config && git init
Add specific folders as submodules:

Add the folders you want to track as submodules:
git submodule add -f /home/.config/xfce
# Add other folders as needed:
# git submodule add -f /home/.config/other-folder  
Commit and push:

Commit the submodule changes: git commit -m "Added submodules"
Push to GitHub: git push -u origin main
Set up post-commit hook (optional):

Create a post-commit hook in .git/hooks/ as before:
#!/bin/sh
git push origin main 

Make it executable: chmod +x .git/hooks/post-commit
Making changes and syncing:

Make changes directly within the original folders (e.g., /home/.config/xfce).
When ready to sync:
Navigate to the main repository: cd ~/dotfiles-config
Commit and push: git commit -m "Updated submodules" && git push
Key points:

Git submodules allow tracking specific folders within a larger repository.
Changes in submodules are committed separately within their respective folders.
Committing and pushing in the main repository updates submodules on GitHub.
The post-commit hook automates pushing for convenience.
Use git submodule update to fetch latest changes from GitHub to your local submodules.
For more complex scenarios, consider tools like stow or custom scripts, as mentioned earlier.




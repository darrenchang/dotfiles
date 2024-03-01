## My dotfile!
For me.

## How to set up
```bash
# Remove existing dotfiles
rm -rf .gitignore
rm -rf .gitmodules
rm -rf .config/nvim
rm -rf .tmux.conf
rm -rf .tmux/
rm -rf .local/share/nvim
rm -rf .git
rm -rf README.md

# Clone Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Initialize git at `~/` and pull
cd ~/
git init
git remote add origin git@github.com:darrenchang/dotfiles.git
git pull origin main

# Initialize and pull submodules
git submodule init
git submodule update
```

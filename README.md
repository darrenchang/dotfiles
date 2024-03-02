## My dotfile!
For me.

## How to set up
```bash
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Install zsh powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Remove existing dotfiles
rm -rf .zshrc
rm -rf .p10k.zsh
rm -rf .oh-my-zsh/
rm -rf .gitignore
rm -rf .gitmodules
rm -rf .config/nvim
rm -rf .tmux.conf
rm -rf .tmux-platform-icon.sh
rm -rf .tmux-copy-to-clipboard.sh
rm -rf .tmux-mouse-monitor.sh
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
git checkout -b main
git pull origin main
git branch --set-upstream-to=origin/main main

# Initialize and pull submodules
git submodule init
git submodule update
```

## Tmux plugins install
1. Tmux plugins will automatically install upon launch.

## Nvim plugins install
1. Nvim plugins will automatically install upon launch.

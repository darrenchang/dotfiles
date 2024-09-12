# My dotfile!
For me.

## Screenshots
<img width="1440" alt="screenshot" src="https://github.com/darrenchang/dotfiles/assets/10385811/78d89d0e-5d32-4c2a-9fca-b2c83f781c37">

# Requirements
Packages that should be installed on the host for this to work as expected.
- tmux <https://github.com/tmux/tmux>
- neovim <https://github.com/neovim/neovim>
- ripgrep <https://github.com/BurntSushi/ripgrep>

# How to set up
```bash
setopt interactivecomments

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

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm -rf .zshrc
# Install zsh powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# Install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install docker autocompletion
mkdir -p ~/.oh-my-zsh/plugins/docker/
curl -fLo ~/.oh-my-zsh/plugins/docker/_docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker

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

# Tmux plugins install
1. Tmux plugins will automatically install upon launch. In a tmux session, press `prefix` + `I` (capital i, as in 
Install) to fetch the plugin

# Nvim plugins install
1. Nvim plugins will automatically install upon launch.

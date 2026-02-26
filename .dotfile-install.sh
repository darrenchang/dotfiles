#!/bin/bash

set -e

# Remove existing dotfiles
rm -rf .zshrc && \
rm -rf .p10k.zsh && 
rm -rf .oh-my-zsh/ && \
rm -rf .gitignore && \
rm -rf .gitmodules && \
rm -rf .config/nvim && \
rm -rf .dotfile-install.sh && \
rm -rf .tmux.conf && \
rm -rf .tmux-platform-icon.sh && \
rm -rf .tmux-copy-to-clipboard.sh && \
rm -rf .tmux-mouse-monitor.sh && \
rm -rf .tmux/ && \
rm -rf .local/share/nvim && \
rm -rf .git && \
rm -rf .config/ghostty/config && \
rm -rf .config/skhd/skhdrc && \
rm -rf .tmux-clients.sh && \
rm -rf README.md;

OS_NAME=$(uname -s);
OS_ARCH=$(uname -m);

# Install nvim
case "$OS_NAME" in
  "Linux")
    case "$OS_ARCH" in
      "x86_64")
        NVIM_ARCH="x86_64"
        ;;
      "aarch64")
        NVIM_ARCH="arm64"
        ;;
    esac
    NVIM_VERSION="v0.11.6";
    sudo apt update && \
    sudo apt install -y luarocks npm python3-venv && \
    curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz && \
    rm -rf ~/tmp-nvim && \
    mkdir -p ~/tmp-nvim && \
    tar -xzf nvim.tar.gz -C ~/tmp-nvim --strip-components=1 && \
    mkdir -p ~/.local/share/mybin/nvim/usr/ && \
    cp -r ~/tmp-nvim/* ~/.local/share/mybin/nvim/usr/ && \
    rm -rf ~/tmp-nvim && \
    rm -f nvim.tar.gz;
    ;;
  "Darwin")
    brew install nvim;
    ;;
  *)
    echo "Nvim not available for the current platform ${OS_NAME} ${OS_ARCH}"
    ;;
esac

# Install laygit
case "$OS_NAME" in
  "Linux")
    case "$OS_ARCH" in
      "x86_64")
        LAZYGIT_ARCH="x86_64"
        ;;
      "aarch64")
        LAZYGIT_ARCH="arm64"
        ;;
    esac
    LAZYGIT_VERSION="0.57.0";
    curl -L -o lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_linux_${LAZYGIT_ARCH}.tar.gz && \
    rm -rf ~/tmp-lazygit && \
    mkdir -p ~/tmp-lazygit && \
    tar -xzf lazygit.tar.gz -C ~/tmp-lazygit && \
    mkdir -p ~/.local/share/mybin/lazygit/usr/bin/ && \
    cp -r ~/tmp-lazygit/* ~/.local/share/mybin/lazygit/usr/bin/ && \
    rm -rf ~/tmp-lazygit && \
    rm -f lazygit.tar.gz;
    ;;
  "Darwin")
    brew install lazygit;
    ;;
  *)
    echo "Nvim not available for the current platform ${OS_NAME} ${OS_ARCH}"
    ;;
esac

# Install oh-my-zsh
sudo apt install -y zsh && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
rm -rf .zshrc && \
# Install zsh powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;
# Install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;

# Install docker autocompletion
mkdir -p ~/.oh-my-zsh/plugins/docker/ && \
curl -fLo ~/.oh-my-zsh/plugins/docker/_docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker;

# Initialize git at `~/` and pull
( \
  cd ~/ && \
  git init && \
  git remote add origin git@github.com:darrenchang/dotfiles.git && \
  git checkout -b main && \
  git pull origin main && \
  git branch --set-upstream-to=origin/main main; \
  # Initialize and pull submodules
  git submodule init && \
  git submodule update;
)


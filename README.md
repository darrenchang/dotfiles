## My dotfile!
For me.

## How to set up
1. Prepare the home directory
    ```
    rm -rf .gitignore
    rm -rf gitmodules
    rm -rf config/nvim
    rm -rf .tmux.conf
    rm -rf .tmux/
    rm -rf .local/share/nvim
    rm -rf .git
    ```

1. Clone Tmux Plugin Manager
    ```
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```

2. Initialize git at `~/` and pull
    ```
    cd ~/
    git init
    git remote add origin https://github.com/darrenchang/dotfiles
    git pull origin main
    ```

3. Initialize and pull submodules
    ```
    git submodule init
    git submodule update
    ```


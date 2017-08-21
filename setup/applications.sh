#!/bin/sh
source ~/dotfiles/setup/functions.sh

if ! command -v brew >/dev/null; then
 fancy_echo "Installing Homebrew ..."
   curl -fsS \
     'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

   append_to_zshrc '# recommended by brew doctor'

   # shellcheck disable=SC2016
   append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

   export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
 fancy_echo "Uninstalling old Homebrew-Cask ..."
 brew uninstall --force brew-cask
fi

brew update && brew install `brew outdated`

fancy_echo "Setting up tmux"
brew install tmux
brew install reattach-to-user-namespace
brew install tree
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

fancy_echo "Installing python and setting up Neovim"
brew install python3
brew install neovim/neovim/neovim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install neovim

brew install git
brew install hub

brew tap caskroom/cask
brew cask install iterm2
brew cask install github-desktop
brew cask install dropbox

fancy_echo "Installing Misc Apps"
brew cask install discord
brew cask install spotify


fancy_echo "Setting up Node with NVM"
mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
source ~/dotfiles/setup/shell.sh
nvm install node
nvm alias default node

fancy_echo "Installing global npm packages"
npm install -g npm@latest
npm install -g npm-check-updates browser-sync


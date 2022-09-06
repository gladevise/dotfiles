#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# check neovim installation
if [[ $(command -v nvim) ]]; then
  echo "nvim is already installed"
  nvim --version
else
  echo "nvim isn't installed"
  curl -L -o ~/dotfiles/.cache/nvim --create-dirs https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod 755 ~/dotfiles/.cache/nvim
  sudo cp ~/dotfiles/.cache/nvim /usr/local/bin/nvim

  # Install neovim python
  pip3 install --user pynvim

  # load nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm use --lts
  npm install -g neovim
fi


popd
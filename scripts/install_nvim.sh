#!/bin/bash
# Install cargo packages
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
fi


popd
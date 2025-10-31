#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# check neovim installation
if [[ $(command -v mise) ]]; then
  echo "mise is already installed"
  mise --version
else
  echo "mise isn't installed"
  curl https://mise.run | sh
  ~/.local/bin/mise --version
  ~/.local/bin/mise install
fi

popd
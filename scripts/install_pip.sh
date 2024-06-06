#!/bin/bash

# Install pip packages
pushd $PWD
cd `dirname $0`
echo $PWD

declare -a packages

packages=(
  # build tools
  wheel

  # package updater
  pipdeptree

  # CLI tools
  yt-dlp
  tmuxp
  powerline-status
)

pip3 install --user ${packages[@]}

popd
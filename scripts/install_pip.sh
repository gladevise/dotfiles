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

# Check Ubuntu version
UBUNTU_VERSION=$(lsb_release -rs)

# Compare version and install pipx if version is higher than 24
if (( $(echo "$UBUNTU_VERSION > 24" | bc -l) )); then
  echo "Install with pipx"
  sudo apt update
  sudo apt install -y pipx
  pipx ensurepath
  pipx install ${packages[@]}
else
  echo "Install with pip3"
  pip3 install --user ${packages[@]}
fi

popd
#!/bin/bash

# Install pip packages
pushd $PWD
cd `dirname $0`
echo $PWD

declare -a packages

packages=(

  # Linter
  flake8
  pylint

  # Formatter
  black
  jedi

  # build tools
  wheel

  # package updater
  pipdeptree

  # CLI tools
  yt-dlp
  pdm
  tmuxp
  powerline-status
)

pip3 install --user ${packages[@]}

popd
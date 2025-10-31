#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# ppaを追加する

declare -a packages

packages=(
  # shell
  zsh

  # build tools
  build-essential
  cmake
  automake
  libclang-dev
  libtool
  libboost-all-dev
  exuberant-ctags

  # python
  python3-pip
  python3-venv

  # git
  git

  # terminal tools
  tmux

  # fonts
  fonts-powerline
  fonts-firacode

  # system monitor
  sysstat
  neofetch

  # CLI tools
  xsel
  curl
  wget
  ncdu
  nnn
  rename
  unrar

  # GUI tools
  meld
  gimp
  inkscape

  # Security
  clamav
  clamav-daemon
  libclamunrar
  gufw

  # Network tools
  iftop
  iperf
  speedtest-cli

  # SSH
  openssh-client
  openssh-server

  # Gnome tools
  # gnome-tweak-tool # change to gnome-tweaks since Ubuntu 22.04
  gnome-tweaks
  gnome-shell-extensions

  # Containers
  podman
)

# update & upgrade
sudo apt update && sudo apt upgrade -y
sudo apt install -y ${packages[@]}

# set zsh as default shell
sudo chsh -s $(which zsh)

popd
#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# ppaを追加する

## Add obs ppa
if [ -f "/etc/apt/sources.list.d/obsproject-ubuntu-obs-studio-focal.list" ]; then
  echo "obs ppa is already existed"
else
  sudo add-apt-repository -y ppa:obsproject/obs-studio
fi

## Add git ppa
if [ -f "/etc/apt/sources.list.d/git-core-ubuntu-ppa-focal.list" ]; then
  echo "git ppa is already existed"
else
  sudo add-apt-repository -y ppa:git-core/ppa
fi

## install copyq
sudo add-apt-repository ppa:hluk/copyq
sudo apt update
sudo apt install copyq

declare -a packages

packages=(
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
  vlc
  flameshot
  obs-studio

  # Security
  clamav
  clamav-daemon
  libclamunrar9
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
)


# update & upgrade
sudo apt update && sudo apt upgrade -y
sudo apt install -y ${packages[@]}

popd
#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# ppaを追加する
## Add copyq ppa
if [ -f "/etc/apt/sources.list.d/hluk-ubuntu-copyq-focal.list" ]; then
  echo "copyq ppa is already existed"
else
  sudo add-apt-repository -y ppa:hluk/copyq
fi

## Add lazygit ppa
# if [ -f "/etc/apt/sources.list.d/lazygit-team-ubuntu-release-focal.list" ]; then
#   echo "lazygit ppa is already existed"
# else
#   sudo add-apt-repository -y ppa:lazygit-team/release
# fi

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

## Add kdenlive ppa
if [ -f "/etc/apt/sources.list.d/kdenlive-ubuntu-kdenlive-stable-focal.list" ]; then
  echo "kdenlive ppa is already existed"
else
  sudo add-apt-repository -y ppa:kdenlive/kdenlive-stable
fi

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
  iftop
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
  copyq
  obs-studio
  kdenlive

  # Security
  clamav
  clamav-daemon
  libclamunrar9
  gufw

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
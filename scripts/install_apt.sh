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

  # Input Method
  im-config
  fcitx5
  fcitx5-mozc
  fcitx5-config-qt
  fcitx5-frontend-all

  # Containers
  podman
)

# update & upgrade
sudo apt update && sudo apt upgrade -y
sudo apt install -y ${packages[@]}

# set zsh as default shell
sudo chsh -s $(which zsh) "$USER"

# Install Nerd Font (FiraCode)
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="FiraCode"
if ! fc-list | grep -qi "FiraCode Nerd Font"; then
  echo "Installing $FONT_NAME Nerd Font..."
  mkdir -p "$FONT_DIR"
  NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.tar.xz"
  curl -fsSL "$NERD_FONT_URL" | tar -xJ -C "$FONT_DIR"
  fc-cache -fv
  echo "$FONT_NAME Nerd Font installed"
else
  echo "$FONT_NAME Nerd Font is already installed"
fi

popd

#!/bin/bash
pushd $PWD
cd `dirname $0`
echo $PWD

declare -a packages

packages=(
  # CLI Tools
  exa
  ripgrep
  bat
  fd-find
  bottom
  tealdeer
  starship

  # package updater
  cargo-update
)

# check rustup & cargo installation
if [[  $(command -v rustup)  ]] && [[ $(command -v cargo) ]]; then
  echo "rustup & cargo are already installed"
else
  echo "rustup & cargo aren't installed"
  # Install rustup
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y #disable prompt
fi

# update rustup
#初回インストール時はログアウトするまで`cargo`のパスが通らないので、直接指定する
$HOME/.cargo/bin/rustup update stable

# install build dependencies
sudo apt install -y libssl-dev
# install cargo applications
$HOME/.cargo/bin/cargo install -j4 ${packages[@]}

# install alacritty
./install_alacritty.sh

# install starship
./install_starship.sh

popd
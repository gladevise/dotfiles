#!/bin/bash
# Install cargo packages
pushd $PWD
cd `dirname $0`
echo $PWD

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
sudo apt install libssl-dev
# install cargo applications
cat ./cargo_install_list.txt  | xargs $HOME/.cargo/bin/cargo install -j4

# install alacritty
bash ./install_alacritty.sh

# install starship
bash ./install_starship.sh

popd
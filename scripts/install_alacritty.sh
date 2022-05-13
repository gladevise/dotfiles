#!/bin/bash
# Install alacritty
pushd $PWD
cd `dirname $0`
echo $PWD

source ./utils.sh

# check alacritty installation
if [[  $(command -v alacritty)  ]]; then
  # check alacritty version
  latest_version=$(get_github_latest_release_tag 'alacritty/alacritty' | sed -E 's/^v?([0-9\.]+)/\1/')
  installed_version=$(alacritty --version | awk '{print $2}')
  if [[ $latest_version == $installed_version ]]; then
    echo "Latest version alacritty is installed!"
    popd
    exit
  else
    echo "$(alacritty --version) is NOT latest version!"
    echo "Upgrading to $latest_version"
  fi
else
  echo "alacritty is not installed"
fi

# make applications directory
mkdir -p ~/Apps
cd ~/Apps

if [[ -d ./alacritty ]];then
  echo 'file exists'
  rm -rf alacritty
fi

# Clone repository
git clone https://github.com/alacritty/alacritty
cd alacritty
#chekcout latest version
latest_version_tag=$(get_github_latest_release_tag 'alacritty/alacritty')
git checkout $latest_version_tag

# check rustup & cargo installation
if [[  $(command -v rustup)  ]] && [[ $(command -v cargo) ]]; then
  echo "rustup & cargo are already installed"
else
  echo "rustup & cargo aren't installed"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y #disable prompt
fi

# update rustup
$HOME/.cargo/bin/rustup override set stable
$HOME/.cargo/bin/rustup update stable

# install build dependencies
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# build alacritty
$HOME/.cargo/bin/cargo build --release

# terminfo check
infocmp alacritty

if [ $? == 0 ]; then
  echo "terminfo installed successfully"
else
  echo "faile to install terminfo"
  sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
fi

# create desktop entry
sudo rm /usr/local/bin/alacritty # for avoiding "Text file busy" error
sudo cp target/release/alacritty /usr/local/bin/ # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# add man
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

# add alacritty automatic completions
ALACRITTY_COMPLETION='source ~/Apps/alacritty/extra/completions/alacritty.bash'

grep "$ALACRITTY_COMPLETION" ~/.bashrc

if [ $? == 0 ]; then
  echo "alacritty completions is set"
else
  echo "alacritty completions is NOT set"
  echo -e "\n\n$ALACRITTY_COMPLETION" >> ~/.bashrc
fi

# set alacritty to default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50

popd
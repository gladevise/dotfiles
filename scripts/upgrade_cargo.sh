# cargo パッケージのupgrade
pushd $PWD
cd `dirname $0`

source ./utils.sh

echo 'upgrade cargo packages'
# Update rustup
rustup override set stable
rustup update stable

# Check cargo-update existence
cargo install-update --version
if [ $? != 0 ]; then
  echo "cargo-update is not installed"
  cargo install cargo-update
fi

# Update cargo packages
cargo install-update -a

# Upgrade alacritty
bash ./install_alacritty.sh

# tldrのupdate
if [[ $(command -v tldr)  ]]; then
  echo "Update tldr"
  tldr --update
fi

popd
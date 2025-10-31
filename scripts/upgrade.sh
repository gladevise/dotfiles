pushd $PWD
cd `dirname $0`

sudo apt update && apt list --upgradable && sudo apt upgrade -y

sudo snap refresh

mise upgrade

flatpak update -y

./install_alacritty.sh

code --update-extensions

popd
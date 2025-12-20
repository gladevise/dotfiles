#!/bin/bash

pushd $PWD
cd `dirname $0`

sudo apt update && apt list --upgradable && sudo apt upgrade -y

sudo snap refresh

flatpak update -y

mise self-update -y

mise upgrade

./install_alacritty.sh

code --update-extensions

popd
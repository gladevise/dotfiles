#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

if [[ $(command -v OpenShot.AppImage) ]]; then
  echo "OpenShot is already installed"
else
  echo "OpenShot isn't installed"
  curl -L -o ~/dotfiles/.cache/OpenShot.AppImage --create-dirs https://github.com/OpenShot/openshot-qt/releases/download/v3.0.0/OpenShot-v3.0.0-x86_64.AppImage
  chmod 755 ~/dotfiles/.cache/OpenShot.AppImage
  cp ~/dotfiles/.cache/OpenShot.AppImage ~/.local/bin/OpenShot.AppImage
fi

OpenShot.AppImage --version

popd
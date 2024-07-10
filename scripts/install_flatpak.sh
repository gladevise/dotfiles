#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# Install flatpak
# https://flatpak.org/setup/Ubuntu

sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

popd
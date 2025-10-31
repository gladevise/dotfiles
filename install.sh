#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# Install apt packages
./scripts/install_apt.sh

# Settings for podman
./scripts/settings_podman.sh

# install snap applications
./scripts/install_snap.sh

# install flatpak
./scripts/install_flatpak.sh

# create nvim_env
./scripts/install_nvim.sh

# link dotfiles
./scripts/link.sh

# install mise
./scripts/install_mise.sh

# install alacritty
./scripts/install_alacritty.sh

# settings for bash
./scripts/settings_bash.sh

# settings for desktop
./scripts/gsettings.sh

popd
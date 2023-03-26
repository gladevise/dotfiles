#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# Install apt packages
./scripts/install_apt.sh

# install pip applications
./scripts/install_pip.sh

# install snap applications
./scripts/install_snap.sh

# install cargo applications
./scripts/install_cargo.sh

# install nvm & Node.js & JavaScript packages
./scripts/install_node.sh
./scripts/install_npm.sh

# create nvim_env
./scripts/install_nvim.sh

# link dotfiles
./scripts/link.sh


popd
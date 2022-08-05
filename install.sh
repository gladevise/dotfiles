#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# Install apt packages
bash ./scripts/install_apt.sh

# install pip applications
bash ./scripts/install_pip.sh

# install snap applications
bash ./scripts/install_snap.sh

# install cargo applications
bash ./scripts/install_cargo.sh

# install nvm & Node.js & npm & yarn
bash ./scripts/install_node.sh
bash ./scripts/install_yarn.sh
bash ./scripts/install_npm.sh

# create nvim_env
bash ./scripts/install_nvim.sh

# link dotfiles
bash ./scripts/link.sh

popd
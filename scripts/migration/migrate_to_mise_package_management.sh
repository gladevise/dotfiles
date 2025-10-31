#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# Uninstall pipx packages
pipx uninstall yt-dlp tmuxp powerline-status wheel pipdeptree

sudo apt remove pipx -y

# Uninstall cargo packages
$HOME/.cargo/bin/cargo uninstall eza ripgrep bat fd-find bottom tealdeer cargo-update starship

popd
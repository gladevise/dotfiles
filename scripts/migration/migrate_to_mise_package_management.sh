#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# Uninstall pipx packages
pipx uninstall yt-dlp tmuxp powerline-status wheel pipdeptree

sudo apt remove pipx -y

popd
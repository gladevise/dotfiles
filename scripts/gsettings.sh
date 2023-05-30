#!/bin/bash
pushd $PWD
cd `dirname $0`
echo $PWD

gsettings set org.freedesktop.ibus.panel.emoji hotkey "['<Super>period']"

popd
#!/bin/bash
pushd $PWD
cd `dirname $0`
echo $PWD

gsettings set org.freedesktop.ibus.panel.emoji hotkey "['<Super>period']"

# set nautilus default sort order
gsettings set org.gnome.nautilus.preferences default-sort-order 'mtime'
gsettings set org.gnome.nautilus.preferences default-sort-in-reverse-order 'true'

popd
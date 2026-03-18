#!/bin/bash

pushd $PWD
cd `dirname $0`

# Set fcitx5 as the default input method framework
if command -v im-config &>/dev/null && command -v fcitx5 &>/dev/null; then
  im-config -n fcitx5
  echo "fcitx5 has been set as the default input method framework."
  echo "Please reboot for the changes to take effect."
else
  echo "WARNING: fcitx5 or im-config is not installed. Run install_apt.sh first."
fi

popd

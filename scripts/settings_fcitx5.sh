#!/bin/bash

pushd $PWD
cd `dirname $0`

# Set fcitx5 as the default input method framework
if command -v im-config &>/dev/null && command -v fcitx5 &>/dev/null; then
  im-config -n fcitx5
  echo "fcitx5 has been set as the default input method framework."
else
  echo "ERROR: fcitx5 or im-config is not installed. Run install_apt.sh first."
  exit 1
fi

# Generate Japanese locale
if ! locale -a 2>/dev/null | grep -q 'ja_JP\.utf8'; then
  echo "Generating ja_JP.UTF-8 locale..."
  sudo locale-gen ja_JP.UTF-8
  echo "ja_JP.UTF-8 locale generated."
else
  echo "ja_JP.UTF-8 locale is already available."
fi

echo "Please reboot for the changes to take effect."

popd

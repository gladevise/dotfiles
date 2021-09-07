#!/bin/bash
# install apt applications

pushd $PWD
cd `dirname $0`
echo $PWD

# ppaを追加する
## Add copyq ppa
if [ -f "/etc/apt/sources.list.d/hluk-ubuntu-copyq-focal.list" ]; then
  echo "copyq ppa is already existed"
else
  sudo add-apt-repository -y ppa:hluk/copyq
fi

## Add lazygit ppa
if [ -f "/etc/apt/sources.list.d/lazygit-team-ubuntu-release-focal.list" ]; then
  echo "lazygit ppa is already existed"
else
  sudo add-apt-repository -y ppa:lazygit-team/release
fi

## Add obs ppa
if [ -f "/etc/apt/sources.list.d/obsproject-ubuntu-obs-studio-focal.list" ]; then
  echo "obs ppa is already existed"
else
  sudo add-apt-repository -y ppa:obsproject/obs-studio
fi

## Add git ppa
if [ -f "/etc/apt/sources.list.d/git-core-ubuntu-ppa-focal.list" ]; then
  echo "git ppa is already existed"
else
  sudo add-apt-repository -y ppa:git-core/ppa
fi

## Add kdenlive ppa
if [ -f "/etc/apt/sources.list.d/kdenlive-ubuntu-kdenlive-stable-focal.list" ]; then
  echo "kdenlive ppa is already existed"
else
  sudo add-apt-repository -y ppa:kdenlive/kdenlive-stable
fi

# update & upgrade
sudo apt update && sudo apt upgrade -y
cat ./apt_install_list.txt  | xargs sudo apt install -y

popd
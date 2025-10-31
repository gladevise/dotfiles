#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

sudo snap install blender --classic
sudo snap install vlc

popd
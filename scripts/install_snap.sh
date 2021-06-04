#!/bin/bash
# Install snap packages
pushd $PWD
cd `dirname $0`
echo $PWD

cat ./snap_install_list.txt  | xargs sudo snap install

popd
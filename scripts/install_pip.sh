#!/bin/bash

# Install pip packages
pushd $PWD
cd `dirname $0`
echo $PWD

pip3 install --user -r ./pip_install_list.txt

popd
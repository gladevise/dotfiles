#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

nvm use --lts
cat ./npm_install_list.txt  | xargs npm -g install

popd
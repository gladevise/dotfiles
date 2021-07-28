#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm use --lts
cat ./npm_install_list.txt  | xargs npm -g install

popd
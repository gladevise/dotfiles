#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD


declare -a packages

packages=(
  # Linter
  eslint

  # CLI Tools
  serve
  nodemon
  lighthouse
  @jarred/git-peek

  # Package updater
  npm-check-updates

  # Package manager
  pnpm
)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm use --lts
npm -g install ${packages[@]}

popd
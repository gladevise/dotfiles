#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

source ./utils.sh

latest_version_tag=$(get_github_latest_release_tag 'nvm-sh/nvm')
echo "latest version: $latest_version_tag"

# install nvm & Node.js & npm
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$latest_version_tag/install.sh" | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# install LTS version Node.js
if [[  $(command -v node)  ]]; then
  nvm install lts/*  --reinstall-packages-from=node
else
  nvm install --lts
fi

nvm use --lts

popd
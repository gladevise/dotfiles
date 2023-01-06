pushd $PWD
cd `dirname $0`

source ./utils.sh

echo 'upgrade npm packages'

npm-check-updates -g | capture_command
upgradable_packages=$(echo $(get_command) | sed -En 's/.*npm -g install (.*)$/\1/gp')

if [[ -n $upgradable_packages ]];then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm use --lts
  npm -g install $upgradable_packages
fi

popd
pushd $PWD
cd `dirname $0`

source ./utils.sh

echo 'upgrade npm packages'

ncu -g | capture_command
upgradable_packages=$(echo $(get_command) | sed -En 's/.*npm -g install (.*)$/\1/gp')

if [[ -n $upgradable_packages ]];then
  npm -g install $upgradable_packages
fi

popd
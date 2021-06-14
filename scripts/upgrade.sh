pushd $PWD
cd `dirname $0`

bash ./upgrade_apt.sh

bash ./upgrade_pip.sh

popd
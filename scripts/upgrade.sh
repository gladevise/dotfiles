pushd $PWD
cd `dirname $0`

./upgrade_apt.sh

./upgrade_pip.sh

./upgrade_cargo.sh

./install_node.sh

./upgrade_npm.sh

popd
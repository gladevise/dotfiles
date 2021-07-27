pushd $PWD
cd `dirname $0`

bash ./upgrade_apt.sh

bash ./upgrade_pip.sh

bash ./upgrade_cargo.sh

bash ./install_node.sh

bash ./upgrade_npm.sh

popd
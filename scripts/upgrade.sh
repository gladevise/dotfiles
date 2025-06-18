pushd $PWD
cd `dirname $0`

./upgrade_apt.sh

sudo snap refresh

./upgrade_flatpak.sh

./upgrade_pip.sh

./upgrade_cargo.sh

./install_node.sh

./upgrade_npm.sh

./upgrade_vscode_extensions.sh

popd
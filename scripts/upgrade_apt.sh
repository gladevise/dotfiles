pushd $PWD
cd `dirname $0`

echo 'upgrade apt packages'
sudo apt update && apt list --upgradable && sudo apt upgrade -y

popd
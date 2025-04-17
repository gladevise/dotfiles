pushd $PWD
cd `dirname $0`

echo 'upgrade vscode extensions'
code --update-extensions

popd

#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# check vscode installation
if [[ $(command -v code) ]]; then
  echo "Install VSCode extensions"
  xargs -a ./vscode_extensions_list.txt -I _ code --install-extension _
else
  echo "VSCode isn't installed"
fi

popd

#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

# check vscode installation
if [[ $(command -v code) ]]; then
  echo "Export VSCode extensions"
  code --list-extensions | tee vscode_extensions_list.txt
else
  echo "VSCode isn't installed"
fi

popd
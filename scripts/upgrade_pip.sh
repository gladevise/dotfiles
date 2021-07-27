# user install されたPythonパッケージをアップグレードする
pushd $PWD
cd `dirname $0`

source ./utils.sh

echo 'upgrade pip packages'

# outdated なパッケージを抽出する
echo 'outdated packages'
echo "------------------------"
## Package と ------------------ の文字列をSkipするため、awkで3行目以降を抽出する
pip3 list --outdated --user | awk 'NR>2{print $1}' | capture_command
## 文字列から配列を生成する
IFS=" " read -r -a outdated_packages <<< $(echo $(get_command))
echo -e "------------------------\n"

# pipdeptree を使ってtop levelのパッケージのみをリスト化する
## pipdeptreeがない場合、インストールする
if [[ ! $(command -v pipdeptree)  ]]; then
  echo "install pipdeptree"
  pip3 install --user pipdeptree
fi

echo 'toplevel packages'
echo "------------------------"
## grepでtop levelのパッケージのみを抽出する
## awkで=とパッケージのバージョン情報を消し、パッケージ名だけを抽出する
pipdeptree -u --warn silence | grep -E '^\w+' | awk '{ result = gensub(/([^=]+).*/, "\\1", "g"); print result;}' | capture_command
IFS=" " read -r -a toplevel_packages <<< $(echo $(get_command))
## pipdeptreeがpipを除外してしまうので、追加する
toplevel_packages+=(pip)
echo -e "------------------------\n"


# outdated_packagesとtoplevel_packagesの&を取る
echo 'upgradable packages'
echo "------------------------"
## 2つの配列を全て展開、trでスペースを改行に置換、sortで行ごとに並び替え、uniqで重複する行のみを抽出する
echo ${outdated_packages[@]} ${toplevel_packages[@]} | tr ' ' '\n' | sort | uniq -d | capture_command
echo -e "------------------------\n"

# 抽出したリストのパッケージをアップグレードする
if [[ -n "$(get_command)" ]]; then
  pip3 install --user -U $(echo $(get_command) )
else
  echo 'No upgradable packages'
fi


popd
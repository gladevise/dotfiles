#!/bin/bash

pushd $PWD
cd `dirname $0`

SEARCH_PATH='../settings'

create_dotfiles_directory(){
  [[ $1 =~ $SEARCH_PATH(.*) ]]
  dotfile_directory=$(realpath $HOME${BASH_REMATCH[1]})
  if [[ ! -d $dotfile_directory ]]; then
    echo "$dotfile_directory does not exist"
    mkdir -p $dotfile_directory
  fi
}

link_dotfiles(){
  [[ $1 =~ $SEARCH_PATH(.*) ]]
  # do not expand symbolic link with -s option
  dotfile_destination=$(realpath -s $HOME${BASH_REMATCH[1]})
  dotfile_source=$(realpath -s $1)
  ln -snfv $dotfile_source $dotfile_destination
}

export -f create_dotfiles_directory
export -f link_dotfiles

# Create empty .gitconfig for not tracking global git settings with dotfiles(.config/git/config)
# For example user.email & user.name
if [[ ! -e ~/.gitconfig ]];then
  echo ".gitconfig file is not exist"
  touch ~/.gitconfig
fi

# search dotfiles directories
for dir in $(find $SEARCH_PATH -type d); do create_dotfiles_directory $dir; done

# link dotfiles
for dir in $(find $SEARCH_PATH -type f); do link_dotfiles $dir; done

popd
#!/bin/bash

pushd $PWD
cd `dirname $0`

SEARCH_PATH='../settings'

unlink_dotfiles(){
  [[ $1 =~ $SEARCH_PATH(.*) ]]
  # do not expand symbolic link with -s option
  dotfile_destination=$(realpath -s $HOME${BASH_REMATCH[1]})
  dotfile_source=$(realpath -s $1)

  # Check if the destination is a symbolic link pointing to the source
  if [[ -L $dotfile_destination ]]; then
    link_target=$(readlink $dotfile_destination)
    if [[ $link_target == $dotfile_source ]]; then
      unlink $dotfile_destination && echo "removed '$dotfile_destination'"
    else
      echo "Skipping $dotfile_destination: link target does not match ($link_target)"
    fi
  else
    echo "Skipping $dotfile_destination: not a symbolic link"
  fi
}

export -f unlink_dotfiles

# unlink dotfiles
for file in $(find $SEARCH_PATH -type f); do unlink_dotfiles $file; done

popd

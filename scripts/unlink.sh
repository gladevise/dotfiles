#!/bin/bash

# Parse options
DRY_RUN=false
while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--dry-run)
      DRY_RUN=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [-n|--dry-run]"
      exit 1
      ;;
  esac
done

export DRY_RUN

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
      if [[ $DRY_RUN == true ]]; then
        echo "[dry-run] would unlink '$dotfile_destination'"
      else
        unlink $dotfile_destination && echo "unlinked '$dotfile_destination'"
      fi
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

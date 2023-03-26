#!/bin/bash

pushd $PWD
cd `dirname $0`
echo $PWD

echo 'Removing apt cache...'
sudo apt-get clean

echo 'Removing snap cache...'
 # https://www.debugpoint.com/clean-up-snap/
  set -eu
  LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
      sudo snap remove "$snapname" --revision="$revision"
    done

if [[ $(command -v flatpak) ]]; then
  echo 'Removing flatpak cache...'
  flatpak uninstall --unused
fi

if [[ $(command -v pip) ]]; then
  # https://pip.pypa.io/en/stable/cli/pip_cache/
  echo 'Removing pip cache...'
  pip cache purge
fi

if [[ $(command -v npm) ]]; then
  # https://docs.npmjs.com/cli/v9/commands/npm-cache?v=true
  echo 'Removing npm cache...'
  npm cache verify
fi

if [[ $(command -v pnpm) ]]; then
  # https://pnpm.io/cli/store#prune
  echo 'Removing pnpm cache...'
  pnpm store prune
fi

if [[ $(command -v cargo) ]]; then
  # https://github.com/matthiaskrgr/cargo-cache
  if [[ ! $(command -v cargo-cache) ]]; then
    echo 'Installing cargo-cache...'
    cargo install cargo-cache
  fi
  echo 'Removing cargo cache...'
  cargo-cache -a
fi

if [[ $(command -v huggingface-cli) ]]; then
  # https://huggingface.co/docs/huggingface_hub/v0.13.3/guides/manage-cache#using-the-tui
  echo 'Removing huggingface cache...'
  huggingface-cli delete-cache
fi

popd
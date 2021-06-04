#!/bin/bash
pushd $PWD
cd `dirname $0`
echo $PWD

ln -snfv ~/dotfiles/settings/.bash_aliases ~/.bash_aliases
ln -snfv ~/dotfiles/settings/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -snfv ~/dotfiles/settings/.config/nvim/ftplugin/javascript.vim ~/.config/nvim/ftplugin/javascript.vim
ln -snfv ~/dotfiles/settings/.config/nvim/ftplugin/css.vim ~/.config/nvim/ftplugin/css.vim
ln -snfv ~/dotfiles/settings/.config/nvim/ftplugin/scss.vim ~/.config/nvim/ftplugin/scss.vim
ln -snfv ~/dotfiles/settings/.config/nvim/ftplugin/sass.vim ~/.config/nvim/ftplugin/sass.vim
ln -snfv ~/dotfiles/settings/.config/nvim/ftplugin/html.vim ~/.config/nvim/ftplugin/html.vim
ln -snfv ~/dotfiles/settings/.config/nvim/ftplugin/vue.vim ~/.config/nvim/ftplugin/vue.vim
ln -snfv ~/dotfiles/settings/.config/nvim/ftplugin/csv.vim ~/.config/nvim/ftplugin/csv.vim
ln -snfv ~/dotfiles/settings/.config/nvim/ftdetect/cloudformation.vim ~/.config/nvim/ftdetect/cloudformation.vim
ln -snfv ~/dotfiles/settings/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -snfv ~/dotfiles/settings/.tmux.conf ~/.tmux.conf
ln -snfv ~/dotfiles/settings/.hyper.js ~/.hyper.js
ln -snfv ~/dotfiles/settings/.stylelintrc ~/.stylelintrc
ln -snfv ~/dotfiles/settings/.textlintrc.json ~/.textlintrc.json
ln -snfv ~/dotfiles/settings/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -snfv ~/dotfiles/settings/.config/starship.toml ~/.config/starship.toml
ln -snfv ~/dotfiles/settings/.config/git/ignore ~/.config/git/ignore
ln -snfv ~/dotfiles/settings/.config/git/config ~/.config/git/config
ln -snfv ~/dotfiles/settings/.dprint.json ~/.dprint.json

popd
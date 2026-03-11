#!/bin/bash
# 旧vim-plug環境からLazyVimへの移行

# 旧init.vimシンボリックリンクの削除
if [ -L ~/.config/nvim/init.vim ]; then
  unlink ~/.config/nvim/init.vim
  echo "Removed old init.vim symlink"
fi

# vim-plugの残骸を削除
rm -rf ~/.local/share/nvim/plugged
rm -f ~/.local/share/nvim/site/autoload/plug.vim

# 旧AppImage Neovimの削除（mise管理に移行）
if [ -f /usr/local/bin/nvim ]; then
  sudo rm /usr/local/bin/nvim
  echo "Removed old AppImage Neovim from /usr/local/bin"
fi

# 旧neovim python/node providerの削除
pip3 uninstall -y pynvim 2>/dev/null || true

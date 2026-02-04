# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

eval "$(~/.local/bin/mise activate zsh)"
eval "$(starship init zsh)"
source <(fzf --zsh)

if [[ $(command -v eza) ]]; then
  alias e='eza --icons'
  alias l=e
  alias ls=e
  alias ea='eza -a --icons'
  alias la=ea
  alias ee='eza -aal --icons'
  alias ll=ee
  alias et='eza -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='eza -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r' #color=alwaysにすることでlessにezaの出力結果を色付きで渡せる
  alias lta=eta
fi

if [[ $(command -v bat) ]]; then
  alias cat=bat
fi

if [[ $(command -v fd) ]]; then
  alias fdh='fd --no-ignore --hidden --follow'
fi

if [[ $(command -v rg) ]]; then
  alias rgh='rg --hidden --no-ignore'
fi

if [[ $(command -v ug) ]]; then
  alias ugh='ug --hidden'
fi

upg(){
  ~/dotfiles/scripts/upgrade.sh
}

lazypodman(){
  export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
  lazydocker
}

# wezterm
alias wezterm='flatpak run org.wezfurlong.wezterm'
# unrar command aliases
alias rarx='unrar x'

# ghostty workaround for VK_ERROR_INCOMPATIBLE_DRIVER
# https://github.com/ghostty-org/ghostty/discussions/8863#discussioncomment-14529500
alias ghostty='GALLIUM_DRIVER=llvmpipe ghostty'
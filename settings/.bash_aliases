alias pip=pip3
alias python=python3
alias py=python3
alias i=nvim
alias aptupg='sudo apt update && apt list --upgradable && sudo apt upgrade -y'

# sudo nvim
alias sdv='sudo -E -s nvim'

# eza aliases
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

alias tm=tmux
alias tma='tmux attach'
alias tml='tmuxp load -y'

# git command aliases
alias gia='git add'
alias gic='git commit -m'
alias gip='git push'
alias gib='git branch'

# tar command aliases
alias tarx='tar -xvf'
alias tarc='tar -cvf'
alias tarbz2x='tar -jxvf'
alias tarbz2c='tar -jcvf'
alias tarxzx='tar -Jxvf'
alias tarxzc='tar -Jcvf'
alias targzx='tar -zxvf'
alias targzc='tar -zcvf'

# unrar command aliases
alias rarx='unrar x'

# ROS command aliases
alias cm='catkin_make'
alias cs='source ~/catkin_ws/devel/setup.bash'
alias rosmon='nodemon -w "./src" -x "catkin_make -DCMAKE_EXPORT_COMPILE_COMMANDS=1" -e "hpp,cpp,xml"'

# C++ project aliases
alias cppmon='nodemon -w "../" -x "make -j8" -e "hpp,cpp"'
alias cpptest='nodemon -w "../" -x "make -j8 && make test" -e "hpp,cpp" -q --spawn'

# Node command aliases
alias mi='pnpm install'
alias mup='pnpm up --latest'
alias mrm='pnpm remove'
alias mru='pnpm run'
alias mex='pnpm exec'
alias mx='pnpm dlx'

# Docker command aliases
alias dcru='docker container run'
alias dcex='docker container exec'
alias dcls='docker container ls'
alias dcrm='docker container rm'
alias dpup='docker compose up'
alias dpdw='docker compose down'
alias dpex='docker compose exec'

# pdm aliases
alias pr='pdm run'

# wezterm
alias wezterm='flatpak run org.wezfurlong.wezterm'

# create directory and file at once
mkt(){
  mkdir -p "$(dirname "$1")" && touch "$1" ;
}

upg(){
  ~/dotfiles/scripts/upgrade.sh
}
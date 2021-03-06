alias pip=pip3
alias python=python3
alias i=nvim
alias aptupg='sudo apt update && apt list --upgradable && sudo apt upgrade -y && sudo apt autoremove -y'
alias lg=lazygit

# exa aliases
if [[ $(command -v exa) ]]; then
  alias e='exa --icons'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons'
  alias la=ea
  alias ee='exa -aal --icons'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r' #color=alwaysにすることでlessにexaの出力結果を色付きで渡せる
  alias lta=eta
fi

if [[ $(command -v bat) ]]; then
  alias cat=bat
fi

alias tm=tmux
alias tma='tmux attach'

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

# ROS command aliases
alias cm='catkin_make'
alias cs='source ~/catkin_ws/devel/setup.bash'

# C++ project aliases
alias cppmon='nodemon -w "../" -x "make -j8" -e "hpp,cpp"'
alias cpptest='nodemon -w "../" -x "make -j8 && make test" -e "hpp,cpp" -q --spawn'

# Node command aliases
alias nrd='npm run develop'
alias nrb='npm run build'
alias nrs='npm run serve'
alias yad='yarn develop'
alias yab='yarn build'
alias yas='yarn start'
alias bs='browser-sync start --server --files "*, ./**/*.css, ./**/*.js"'

# create directory and file at once
mkt(){
  mkdir -p "$(dirname "$1")" && touch "$1" ;
}

" leader keyを設定
let g:mapleader = ' '
" Release keymappings for plug-in.
nnoremap <Space> <Nop>

" fileformatの設定
setglobal fileformat=unix

" "vim-polyglot settings"
let g:polyglot_disabled = ['md'] " ~/.vimrc, declare this variable before polyglot is loaded

" vim-plugが無かったら自動でダウンロードする
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" init.vimを編集したら自動でinit.vimをリロードする
augroup reload_initvim
    au!
    au BufWritePost init.vim so $MYVIMRC | call LightlineReload()
augroup end

" init.vimをReloadするとLightlineが消えてしまうので、Lightlineをリロードする
command! LightlineReload call LightlineReload()
function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" .tmux.confを編集したら自動で.tmux.confをリロードする "&& tmux refresh-client}
augroup reload_tmuxconf
    autocmd!
    au BufWritePost .tmux.conf :silent! !tmux source-file ~/.tmux.conf && tmux refresh-client
augroup end

" pluginをインストール
call plug#begin('~/.local/share/nvim/plugged')

" PCRE(perlの正規表現)を使えるようにする
" Plug 'othree/eregex.vim'
" regexのプレビューが効かなくなった。完全にPerlライクに書けるわけでもなかった

" カラースキーム
Plug 'joshdick/onedark.vim' " Dark Theme
Plug 'itchyny/lightline.vim' " status line

" 空白の可視化
Plug 'ntpeters/vim-better-whitespace'

" インデント可視化
Plug 'Yggdroot/indentLine'

" ルートディレクトリを.gitのあるディレクトリに変更する
Plug 'airblade/vim-rooter'

" 多言語対応
Plug 'sheerun/vim-polyglot'

" コメントアウト
Plug 'tomtom/tcomment_vim' " コンテキストを解釈してコメントアウトしてくれる

" Undo
Plug 'mbbill/undotree'

" カーソル移動
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

" 囲み文字の編集
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" 自動で括弧を閉じる
Plug 'jiangmiao/auto-pairs'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }

" advanced yank history
Plug 'svermeulen/vim-yoink'

call plug#end()

" Pythonパスの設定
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog  = '/usr/bin/python3'

""" "plugin settings" """
" "lightline settings"
set termguicolors
colorscheme onedark
function LightlineObsessionStatus()
    return '%{ObsessionStatus("*", "obsession not started")}'
endfunction
let g:lightline = {'colorscheme': 'onedark'}
let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'obsession_status' ] ] }

let g:lightline.component_expand = {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \   'obsession_status': 'LightlineObsessionStatus',
  \ }
let g:lightline.component_type = {
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \ }
let g:lightline.active = {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['readonly', 'filename', 'modified'],
  \     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
  \   ]
  \ }

" "ntpeters/vim-better-whitespaceの設定"
" 無駄な空白のハイライトと保存時の削除
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm = 0 "確認なしに空白行を削除する"

" "vim-rooter settings"
let g:rooter_patterns = ['package.json', ".eslintrc.*", ".env.*", ".git"]

" "undotree settings"
nnoremap <leader>u :UndotreeToggle<cr>

" "vim-easymotion settings"
" s{char}{char} to move to {char}{char}
map <leader>s <Plug>(easymotion-bd-f2)
nmap <leader>s <Plug>(easymotion-overwin-f2)
" Move to line
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)
" incsearch_config
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction
" fuzzy search config
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> / incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ? incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

" "vim-markdown settings"
let g:vim_markdown_conceal = 0 " 全てのconcealを無効化
let g:vim_markdown_conceal_code_blocks = 0 " markdownのコードブロックの``を隠さないように設定する

" "markdown-preview.nvim settings"
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0
" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0
" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1
map <leader>mp :MarkdownPreview<CR>

" "vim-yoink settings"
" cycle yank history
nmap <c-p> <plug>(YoinkPostPasteSwapBack)
nmap <c-n> <plug>(YoinkPostPasteSwapForward)

" paste below
nmap p <plug>(YoinkPaste_p)
" paste above
nmap P <plug>(YoinkPaste_P)

" show yank history
nmap <leader>yh :Yanks<CR>

" delete operations such as x or d or s will also be added to the yank history.
let g:yoinkIncludeDeleteOperations = 1

" the yank history will be saved persistently across sessions of Vim. Note: Requires Neovim.
let g:yoinkSavePersistently = 1
set shada=!,'100,<50,s10,h

" the cursor will always be placed at the end of the paste.
let g:yoinkMoveCursorToEndOfPaste = 1

" When set to 0, it will cycle back to the other end of the history so you can swap in the same direction forever.
let g:yoinkSwapClampAtEnds = 1
" 1週したかどうかが分かりづらいので0にするのは微妙

" "NeoVim関連の設定"

" 反映されるまでの時間を早くする(for vim-gitgutter)
set updatetime=100

" syntax
syntax on

" 行番号
set number
set relativenumber

" splitwindow
set splitbelow
set splitright

" インデント
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set shiftround

" 検索と置換
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split " 置換をインタラクティブにする insubstitude?とかいうのになったらしい?

" 全角文字で2文字分の幅を使用する
set ambiwidth=double

" クリップボード
" enable xsel
let g:clipboard = {
      \   'name': 'xsel_override',
      \   'copy': {
      \      '+': 'xsel --input --clipboard',
      \      '*': 'xsel --input --primary',
      \    },
      \   'paste': {
      \      '+': 'xsel --output --clipboard',
      \      '*': 'xsel --output --primary',
      \   },
      \   'cache_enabled': 1,
      \ }
" "WSL用の設定"
" Linux DESKTOP-8MJMAB0 4.19.67-microsoft-standard #1 SMP Sun Aug 18 13:37:54 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
if system('uname -a | grep microsoft') != ""
  let g:clipboard = {
        \   'name': 'wslClipboard',
        \   'copy': {
        \      '+': 'win32yank.exe -i',
        \      '*': 'win32yank.exe -i',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o',
        \      '*': 'win32yank.exe -o',
        \   },
        \   'cache_enabled': 1,
        \ }
  " set t_Co=256
  set t_ut=""
  " colorscheme onedark
  " highlight Normal ctermbg=NONE
  " highlight nonText ctermbg=NONE
endif
set clipboard+=unnamedplus

" ファイル関連設定
set encoding=utf-8
set guifont=DroidSansMono\ Nerd\ Font\ 11
set confirm " '終了時に未保存のファイルがある場合、警告する'
set hidden " '未保存のファイルがあっても別のファイルを開ける'
set autoread " '外部でファイルが変更されたら自動的にリロードする'
au FocusGained * :checktime

" keymappings
" <leader>hでHistoryを表示する
nmap <leader>h :History<CR>
" jjでインサートモードから抜ける
inoremap <silent> jj <Esc>
" <ESC><ESC> で検索ハイライトをトグル
nnoremap <ESC><ESC> :set hlsearch!<CR>
" <leader>wで保存
nnoremap <leader>w :w<CR>
" <leader>rでvimrcをリロード
nnoremap <leader>r :so $MYVIMRC <bar> :redraw<CR>
" 移動
" 行移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" タブ移動
nnoremap <c-h> gT
nnoremap <c-l> gt
" タブ自体の移動
nnoremap <A-h> :tabmove-<CR>
nnoremap <A-l> :tabmove+<CR>
" 行頭、行末に移動
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
onoremap H ^
onoremap L $
" splitwindow関連
nnoremap <c-w>_ <c-w>v
nnoremap <c-w>- <c-w>s
nmap <silent> <c-w>J :resize +2<CR>
nmap <silent> <c-w>K :resize -2<CR>
nmap <silent> <c-w>H :vertical resize +2<CR>
nmap <silent> <c-w>L :vertical resize -2<CR>

" comment outの自動挿入を無効
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ROS launch fileをxmlとして読み込み
au BufNewFile,BufRead *.launch setf xml

" "ファイルごとの設定"
set runtimepath+='~/.config/nvim/ftplugin/javascript.vim'
set runtimepath+='~/.config/nvim/ftplugin/css.vim'
set runtimepath+='~/.config/nvim/ftplugin/scss.vim'
set runtimepath+='~/.config/nvim/ftplugin/sass.vim'
set runtimepath+='~/.config/nvim/ftplugin/html.vim'
set runtimepath+='~/.config/nvim/ftplugin/vue.vim'
set runtimepath+='~/.config/nvim/ftplugin/csv.vim'
set runtimepath+='~/.config/nvim/ftdetect/cloudformation.vim'
" autocmd BufWritePost *template.y*ml silent !cfn-format -w % 2>/dev/null " 保存時にCloudFormationのFormatterを実行
filetype plugin indent on

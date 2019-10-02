" leader keyを,に変更
let g:mapleader = ','
" Release keymappings for plug-in.
nnoremap ,  <Nop>

" vim-plugが無かったら自動でダウンロードしてくる
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" init.vimを編集したら自動でinit.vimをリロードして、PlugInstallしてほしい
augroup reload_initvim
    au!
    au BufWritePost init.vim so $MYVIMRC | call LightlineReload() | silent PlugInstall
augroup end

" init.vimをっReloadするとLightlineが消えてしまうので、Lightlineをリロードする
command! LightlineReload call LightlineReload()
function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

call plug#begin('~/.local/share/nvim/plugged')

" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

" カラースキーム
Plug 'joshdick/onedark.vim' " Dark Theme
Plug 'itchyny/lightline.vim' " status line

" 空白の可視化
Plug 'ntpeters/vim-better-whitespace'

" インデント可視化
Plug 'Yggdroot/indentLine'

" あいまい検索
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" ルートディレクトリを.gitのあるディレクトリに変更する
Plug 'airblade/vim-rooter'

" Git関連
" Gitと連携する
Plug 'tpope/vim-fugitive'

" Git差分表示
Plug 'airblade/vim-gitgutter'

" 多言語対応
Plug 'sheerun/vim-polyglot'

" Linter
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

" Snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" 入力補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Terminal & REPL
Plug 'kassio/neoterm'

" コメントアウト
Plug 'tpope/vim-commentary'

" Undo
Plug 'mbbill/undotree'

" カーソル移動
Plug 'easymotion/vim-easymotion'

" 囲み文字の編集
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" 自動で括弧を閉じる
Plug 'jiangmiao/auto-pairs'

call plug#end()

" Pythonパスの設定
let g:python_host_prog  = $HOME . '/Env/python_env/nvim_env/bin/python'
let g:python3_host_prog  = $HOME . '/Env/python_env/nvim_env/bin/python3'

""" "プラグインの設定" """
" "lightline settings"
set termguicolors
colorscheme onedark
let g:lightline = {'colorscheme': 'onedark'}

" "ntpeters/vim-better-whitespaceの設定"
" 無駄な空白のハイライトと保存時の削除
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm = 0 "確認なしに空白行を削除する"

" "ALE Settings"
" C-pでHistoryを表示する
nmap <C-p> :History<CR>
"ALEKeyMap
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" ALE Linters
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_python_flake8_options = '--max-line-length 88'
let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'javascript': ['eslint']
    \ }
let g:ale_lint_on_save = 1
" ALE Fixers
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': ['black'],
  \   'javascript': ['prettier','eslint'],
  \   'css': ['prettier'],
  \   'html': ['prettier'],
  \ }
let g:ale_fix_on_save = 1

" "ALE lightline Settings"
let g:lightline.component_expand = {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
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

" "ultisnips settings"
let g:UltiSnipsExpandTrigger='<c-j>'

" "coc.nvim settings"
" tab で補完候補選択 C-nのほうが好きなのでそのままにする
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" Enterで補完候補を決定する
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" ジャンプの設定
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Uでドキュメントの表示
" なぜかホバー表示にならない
nnoremap <silent> U :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" "neoterm settings"
let g:neoterm_default_mod='belowright' "neotermの起動位置の設定
let g:neoterm_size=10 "neotermのサイズの設定
let g:neoterm_autoscroll=1 "autoscroll
"<C-w>でターミナルの挿入モードを抜ける
tnoremap <silent> <C-w> <C-\><C-n><C-w>
" REPLの設定 C-xで実行
nnoremap <C-x> :TREPLSendLine<CR>
vnoremap <C-x> V:TREPLSendSelection<CR>
" nnoremap <C-S-x> :TREPLSendFile<CR> "Ctrl + Shiftを使ったキーマップはVimの仕様上できないらしい
" 3<leader>tl will clear neoterm-3.
nnoremap <leader>tl :<c-u>exec v:count.'Tclear'<cr>

" "undotree settings"
nnoremap <F5> :UndotreeToggle<cr>

" "vim-easymotion settings"
" s{char}{char} to move to {char}{char}
map <leader>s <Plug>(easymotion-bd-f2)
nmap <leader>s <Plug>(easymotion-overwin-f2)
" Move to line
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)

" "NERDTree settings"
" デフォルトで隠しファイルを表示する (Iでトグルできる)
let g:NERDTreeShowHidden=1
" C-eでNERDTreeをトグル
map <C-e> :NERDTreeToggle<CR>

" 反映されるまでの時間を早くする(for vim-gitgutter)
set updatetime=100

" "NeoVim関連の設定"
" 行番号
set number
" set relativenumber

" インデント
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set shiftround

" 検索と置換
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split " 置換をインタラクティブにする insubstitude?とかいうのになったらしい?

" クリップボード
set clipboard+=unnamedplus
" WSL用のクリップボード設定
if system('uname -a | grep Microsoft') != ""
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
endif

" キーバインド

" jjでインサートモードから抜けると同時にファイルを保存する
inoremap <silent> jj <Esc>:<C-u>w<CR>
" <ESC><ESC> で検索ハイライトをトグル
nnoremap <ESC><ESC> :set hlsearch!<CR>
" 移動
" 行移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" タブ移動
nnoremap J gT
nnoremap K gt
" タブ自体の移動
nnoremap <A-J> :tabmove-<CR>
nnoremap <A-K> :tabmove+<CR>
" <Space> h lで行頭、行末に移動
nnoremap <C-h> ^
nnoremap <C-l> $
vnoremap <C-h> ^
vnoremap <C-l> $

" javascriptでの設定
set runtimepath+='~/.config/nvim/ftplugin/javascript.vim'
filetype plugin indent on

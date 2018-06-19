set nocompatible              " be iMproved, required
filetype off 
" required
set backspace=2
set t_Co=256
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set clipboard=unnamedplus
set clipboard+=unnamedplus
set laststatus=2
" let Vundle manage Vundle, required
let g:airline_theme='hybrid'
let g:airline_powerline_fonts = 1
set noshowmode
set relativenumber
nnoremap p "+p
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'dracula/vim'
" git repos on your local machine (i.e. when working on your own plugin)

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'Townk/vim-autoclose'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Chiel92/vim-autoformat'
" Avoid a name conflict with L9
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'nanotech/jellybeans.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'tssm/fairyfloss.vim'
Plugin 'tpope/vim-sleuth'
Plugin 'romainl/Apprentice'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'Canop/patine'
Plugin 'owickstrom/vim-colors-paramount'
Plugin 'robertmeta/nofrils'
" All of your Plugins must be added before the following line
call vundle#end()            " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :pLUGINlIST       - LISTS CONFIGURED PLUGINs
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set number
set guifont=Fira\ Code:h11
set cursorline

if (has("termguicolors"))
  set termguicolors
endif

set background=dark

colorscheme dracula
let g:nofrils_heavylinenumbers=1 
let g:nofrils_strbackgrounds=1 
let g:nofrils_heavycomments=1 

syntax on
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <D-P> <C-P>
map <D-p> <C-p>

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

set guioptions-=L
set guioptions-=r
set incsearch
set clipboard=unnamed

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set hidden
set nocompatible

let g:jsx_ext_required = 0
set backupdir=~/temp//
set directory=~/temp//
let g:vim_jsx_pretty_colorful_config = 1
autocmd Filetype javascript.jsx setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
autocmd TabEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif


filetype plugin indent on    " required

set colorcolumn=100

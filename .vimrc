

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim' 
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'mhartington/oceanic-next'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim'
Plug '/usr/local/opt/fzf'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'roman/golden-ratio'
call plug#end()

colorscheme dracula

au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

map <silent> <C-k>b :NERDTreeToggle<cr>

let g:ale_fixers = {
  \    'javascript': ['prettier'],
  \    'typescript': ['prettier', 'tslint'],
  \    'vue': ['eslint'],
  \    'scss': ['prettier'],
  \    'html': ['prettier'],
  \    'ejs': ['prettier'],
  \    'reason': ['refmt']
\}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--arrow-parens always'

set clipboard=unnamedplus,unnamed
set hidden

if has("gui_macvim")
	set lines=999 columns=9999
	aunmenu File.Print

	function Find_git_root()
		return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
	endfunction

	nnoremap <D-p> :execute 'Files '. Find_git_root()<Cr>
endif

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

set guioptions=
set number

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

au BufRead,BufNewFile *.ejs set filetype=html


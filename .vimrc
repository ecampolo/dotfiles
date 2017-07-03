call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tomasr/molokai'
Plug 'tpope/vim-commentary'

call plug#end()

" Indentation
"
set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Search
"
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" Backup
"
set nobackup
set nowb
set noswapfile

" Color
"
colorscheme molokai
let g:airline_theme='molokai'

" Functions
"
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" Mappings
"
let mapleader=","
noremap <leader>ss :call StripWhitespace()<CR>

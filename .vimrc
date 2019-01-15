call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-markdown'
Plug 'fxn/vim-monochrome'
Plug 'itchyny/lightline.vim'

call plug#end()

" General
"
set history=1000

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
colorscheme monochrome
if exists('+termguicolors')
    set termguicolors
endif
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

" Mappings
"
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>o :NERDTreeToggle<cr>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

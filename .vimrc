call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'tomasr/molokai'

" Initialize plugin system
call plug#end()

" Set molokai color scheme
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

" Sets how many lines of history VIM has to remember
set history=1000

" Encoding
set encoding=utf-8
set ffs=unix,dos,mac

" A buffer becomes hidden when it is abandoned
set hidden

" We show the mode with airline or lightline
set noshowmode 
" Show me what I'm typing
set showcmd
" Show line numbers
set number

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Don't redraw while executing macros (good performance config)
set lazyredraw
" More characters will be sent to the screen for redrawing
set ttyfast

" Highlight found searches
set hlsearch
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase

" No Backup
set nobackup
set nowritebackup
set noswapfile

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Strip all trailing whitespace from a file, using ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

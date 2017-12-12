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
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-markdown'

call plug#end()

" General
"
set history=500

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
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.java,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Mappings
"
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" map ctrl+p to fzf
map <C-p> :Files<cr>

" map ctrl+o to ripgrep
map <C-o> :Rg

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
noremap <leader>ss :call CleanExtraSpaces()<CR>

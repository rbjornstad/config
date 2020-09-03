colorscheme delek
set backupdir=~/.swap//
set directory=~/.swap//
set undodir=~/.swap//
"
set nocompatible
" {{{ Settings
set textwidth=1400
set wrap
set mmp=50000

" This shows what you are typing as a command.
set showcmd

filetype on
filetype plugin on
filetype plugin indent on
syntax enable
syntax on

set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab

set nospell

set wildmenu
set wildmode=list:longest,full
" ignore these files when completing names and in Ex
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam

" Backspace
set backspace=2

" Line numbers
set number

" Ignore case
set ignorecase

" but only if it makes sense?
set smartcase

" Define leader
let mapleader=","

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Incremental search
set incsearch

" Highlight search
set hlsearch

" Set off the other paren
highlight MatchParen ctermbg=4

" }}}

"{{{ Mappings

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" }}}
" {{{ Visuals

" Highligh current line
set cursorline
" Always show statusline
set laststatus=2

" }}}
" {{{ Custom file patterns syntax

au BufNewFile,BufRead Jenkinsfile setf groovy
" }}}"

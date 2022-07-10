set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set hidden
set noerrorbells
set termguicolors

call plug#begin()
Plug 'nvim-telescope/telescope.nvim'
Plug 'https://github.com/gruvbox-community/gruvbox.git'
"Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/vim-autoformat/vim-autoformat'
call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

"let mapleader = " "
let g:python3_host_prog="/opt/local/bin/python3"
let g:formatdef_av_c = '"astyle --options=${DOTCONF}/.astylerc --project=none"'
let g:formatters_c = ['av_c']
let g:formatdef_av_python = '"python3 -m black"'
let g:formatters_python = ['av_python']

augroup AV
    autocmd!
    autocmd BufWrite *.c,*.py :Autoformat
augroup END


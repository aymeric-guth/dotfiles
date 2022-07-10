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
"Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'nvim-telescope/telescope.nvim'
Plug 'https://github.com/gruvbox-community/gruvbox.git'
call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

let mapleader = " "

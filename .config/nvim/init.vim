call plug#begin('~/.vim/plugged')

Plug 'kaicataldo/material.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'wsdjeg/vim-fetch'
Plug 'jiangmiao/auto-pairs'

"Autocompletion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
"Completion sources
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-pyclang'

call plug#end()

"Basic set up
syntax on
colorscheme material
set nu
set relativenumber
set encoding=utf-8
set hidden "seperate tabs
let mapleader=","
set guifont=inconsolata\ 13

"Disable gvim widgets
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar

"show existing tab with 8 spaces width
"set tabstop=8
""when indenting with '>' use 8 spaces width
"set shiftwidth=8
""on pressing tab, insert 8 spaces
"set expandtab
set autoindent
"set softtabstop=8

" remap
nnoremap k gk
nnoremap j gj
"quick save(if modified)
nnoremap <S-w> :update<CR>
"save and leave(if modified)
"nnoremap <S-x> :write<CR>:quit<CR>
"unmap <Q> ex-mode
nnoremap Q :q!<CR>


" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" always use nasm syntax for .asm files
let asmsyntax="nasm"

" Status bar plugin
set laststatus=2
if !has('gui_running')
        set t_Co=256
endif
set noshowmode
let g:lightline = {
   \ 'colorscheme': 'wombat',
  \}


" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone
let g:ncm2_pyclang#library_path = '/usr/lib64/llvm6.0/lib'

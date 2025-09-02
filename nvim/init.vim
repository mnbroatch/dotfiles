syntax on
set smartindent
set hidden
set number
set noincsearch
set nohlsearch

set shiftwidth=2
set softtabstop=2
set expandtab

let mapleader = " "

lua require('config/lazy')
lua require('config/lsp')

nmap <silent> <silent>gd :ALEGoToDefinition<cr>

" crazy that avante leaves stale TODOs, how annoying
nnoremap <silent> <leader>aD :call system('rm -rf ~/.local/state/nvim/avante')<CR>

set clipboard=unnamed
set suffixesadd=.js

" magic typscript fix for mac
set re=2

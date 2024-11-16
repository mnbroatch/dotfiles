syntax on
set smartindent
set hidden
set number
set noincsearch
set nohlsearch

set shiftwidth=2
set softtabstop=2
set expandtab

set clipboard=unnamed
set suffixesadd=.js

" magic typscript fix for mac
set re=2

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

let g:ale_virtualtext_cursor=0
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_completion_enabled = 1
nmap <silent> <silent>gd :ALEGoToDefinition<cr>

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|built\'

" packloadall
silent! helptags ALL

let mapleader = " "

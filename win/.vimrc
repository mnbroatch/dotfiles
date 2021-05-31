filetype plugin indent on
syntax on
colorscheme oceanic-next
set hidden
set number

set shiftwidth=2
set softtabstop=2
set expandtab

set clipboard=unnamedplus
set suffixesadd=.js

noremap "" "_
nnoremap =- mzgg=G`zz.

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
nmap <silent> <silent>gd :ALEGoToDefinition<cr>

" Custom ignore for ctrl-p
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

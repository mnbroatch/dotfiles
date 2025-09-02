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

" let g:clipboard = {
"     \   'name': 'WslClipboard',
"     \   'copy': {
"     \      '+': 'clip.exe',
"     \      '*': 'clip.exe',
"     \    },
"     \   'paste': {
"     \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
"     \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
"     \   },
"     \   'cache_enabled': 0,
"     \ }

nmap <silent> <silent>gd :ALEGoToDefinition<cr>
nnoremap <silent> <leader>aD :call system('rm -rf ~/.local/state/nvim/avante')<CR>

set clipboard=unnamed
set suffixesadd=.js

" magic typscript fix for mac
set re=2

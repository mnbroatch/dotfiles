set nocompatible

filetype plugin indent on
syntax on

set expandtab
set clipboard=unnamedplus
set wrap
set viminfo='50

set autoread
au FocusGained,BufEnter * :silent! !
set nomore
set hidden

let @l="^y$iconsole.log('$a', pa)"

let g:netrw_liststyle = 3
let g:html_indent_inctags = "li" 
let g:ctrlp_max_files = 0
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {'javascript': ['eslint', 'tsserver']}
let g:ale_fixers = {'javascript': ['eslint', 'tsserver']}

let g:ale_pattern_options = {
\   '.*/stories/.*\.js$': {'ale_enabled': 0},
\}

set foldmethod=indent
set foldlevel=99
set tabstop=2
set shiftwidth=2
set backspace=start
set number
set iskeyword+=\-
set dir=~/.vim/backups/
set tags=./tags,tags;$HOME

nmap <silent> <silent>gd :ALEGoToDefinition<cr>

iabbrev <css> <link rel="stylesheet" type="text/css" href="style.css">
iabbrev <js> <script src="main.js"></script>

" use u to recover from accidental c-u or c-w
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"indent all with =-
nnoremap =- mzgg=G`zz.

"switch fold functions
noremap zA za
noremap za zA

let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|node_modules|\.sass-cache|bin)$',
  \ }
let g:ctrlp_show_hidden = 1

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>p :CtrlPMRU<cr>

"make C-w,C-f go to file under cursor in node in split mode
autocmd User Node
			\ if &filetype == "javascript" |
			\   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
			\   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
			\ endif

nnoremap "" "_

nnoremap > >>
nnoremap < <<

map <leader>s ysiw
map <leader>S ysiW

let g:jsx_ext_required = 0

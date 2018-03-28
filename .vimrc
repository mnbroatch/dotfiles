colorscheme jellybeans
set t_ut=

set autoread
au FocusGained,BufEnter * :silent! !

set viminfo='50
set nocompatible
set expandtab
set clipboard=unnamedplus
set wrap

compiler   gradle
filetype plugin indent on

syntax on
let g:html_indent_inctags = "li" 
let g:ctrlp_max_files = 0
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ale_javascript_eslint_use_global = 1

let g:ale_linters = {'javascript': ['eslint']}

let g:ale_fixers = {'javascript': ['eslint']}

au BufRead,BufNewFile *.ts   setfiletype typescript

set nomore
set foldmethod=indent
set foldlevel=99
set tabstop=2
set shiftwidth=2
set backspace=start
set number
set iskeyword+=\-
set dir=~/.vim/backups/
set tags=./tags,tags;$HOME
" set tags+=./jstags,jstags;$HOME
let g:netrw_liststyle = 3

iabbrev <css> <link rel="stylesheet" type="text/css" href="style.css">
iabbrev <js> <script src="main.js"></script>
iabbrev <jquery> <script   src="https://code.jquery.com/jquery-2.2.4.js"   integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="   crossorigin="anonymous"></script>
iabbrev <grad> background: linear-gradient(Xdeg, red, red 60%, blue);

iabbrev Sc $scope

iabbrev <jsn> JSON.stringify(, null, 2)

" use u to recover from accidental c-u or c-w
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"indent all with =-
nnoremap =- mzgg=G`zz.

"switch fold functions
noremap zA za
noremap za zA

let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|node_modules|\.sass-cache|bower_components|bin)$',
  \ }
let g:ctrlp_show_hidden = 1

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>p :CtrlPMRU<cr>

"simple bracket matching when enter is pressed immediately
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O
inoremap (<cr> (<cr>)<c-o>O
inoremap ({<cr> ({<cr>})<c-o>O

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


runtime! ftplugin/man.vim

let g:jsx_ext_required = 0
xmap <C-j> :!column -t
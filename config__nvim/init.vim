" vim-plug.
call plug#begin()
Plug 'chaoren/vim-wordmotion'
call plug#end()

" Leader key: use either \ or ,.
let mapleader = ","
nmap \ ,

" Don't need shift for ed commands.
nnoremap ; :

" Y should work like D or C (by default yanks the whole line).
nnoremap Y y$

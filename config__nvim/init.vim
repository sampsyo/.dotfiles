" vim-plug.
call plug#begin()
Plug 'chaoren/vim-wordmotion'
Plug 'lifepillar/vim-solarized8'
call plug#end()

" Color scheme.
if has("gui_vimr")
    set background=light
else
    set background=dark
endif
colorscheme solarized8

" Leader key: use either \ or ,.
let mapleader = ","
nmap \ ,

" Don't need shift for ed commands.
nnoremap ; :

" Y should work like D or C (by default yanks the whole line).
nnoremap Y y$

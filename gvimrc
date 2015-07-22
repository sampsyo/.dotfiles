" Default window size.
set columns=80

" Mac vs. Linux font.
if has("gui_macvim")
    set guifont=Source\ Code\ Pro:h10
else
    set guifont=Inconsolata
endif

command -nargs=* VertSplit let &columns = &columns + &textwidth | vs <args>
nmap <Leader>s :VertSplit<CR>
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar

" Vundle loads all the bundles! {{{

" https://github.com/gmarik/vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sickill/vim-pasta'
Bundle 'scrooloose/syntastic'
Bundle 'renamer.vim'
Bundle 'tpope/vim-markdown'
Bundle 'sampsyo/autolink.vim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-fugitive'
Bundle 'a.vim'
Bundle 'ack.vim'
Bundle 'bufkill.vim'
Bundle 'camelcasemotion'
Bundle 'sjbach/lusty'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'mitsuhiko/vim-python-combined'
Bundle 'vcscommand.vim'
Bundle 'Zenburn'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'godlygeek/tabular'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'juvenn/mustache.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mhinz/vim-signify'
Bundle 'Lawrencium'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-abolish'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-sensible'
Bundle 'JuliaLang/julia-vim'
Bundle 'ntpeters/vim-better-whitespace'
filetype plugin indent on

" }}}
" Plugins. {{{

" Vimpager.
let vimpager_use_gvim = 1

" LustyExplorer complains.
let g:LustyJugglerSuppressRubyWarning = 1

" Syntastic config.
let g:syntastic_check_on_open=1
let g:syntastic_echo_current_error=1
let g:syntastic_enable_balloons=1
let g:syntastic_enable_signs=0
let g:syntastic_enable_highlighting=1
let g:syntastic_python_checkers=['flake8']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list=1
" Noisy PEP8 stuff.
" E241 multiple spaces after , (useful for alignment)
let g:syntastic_python_flake8_args="--ignore=E241 --exclude=''"
" Use Clang.
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_c_compiler = 'clang'

" netrw
let g:netrw_silent = 1 " avoid irritating prompt on :w
let g:netrw_keepdir = 0

" NERDTree ignored files.
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '^\.DS_Store$']

" Yankstack.
call yankstack#setup()
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Rainbow parentheses.
nmap <leader>R :RainbowParenthesesToggle<CR>

" CtrlP.
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" bufkill.
nnoremap <leader>x :BD<CR>

" Airline.
set laststatus=2  " Always show status line.
let g:airline_left_sep = ''
let g:airline_right_sep = ''
if has('gui_running')
    let g:airline_theme='solarized'
else
    let g:airline_theme='tomorrow'
end

" Signify (hg/git diff in the gutter).
let g:signify_disable_by_default = 1
nnoremap <leader>d :SignifyToggle<CR>

" }}}
" The basics. {{{

" Syntax highlighting and colors.
set background=light
set cursorline
let g:solarized_contrast="high"    "default value is normal
if has('gui_running')
    colorscheme solarized
else
    colorscheme zenburn
end

" Basic behavior.
set gcr=n:blinkon0 " no blinking
set encoding=utf-8
set showmode
set lazyredraw
set hidden

" Splits in the expected place.
set splitbelow
set splitright

" Indentation.
set textwidth=78
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Emacs-style wrap visibility.
set showbreak=↪

" Instead of annoyingly showing help, toggle fullscreen on help key.
noremap  <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a

" Mouse.
set mouse=a

" Terminal title.
set title

" Spelling.
set spell spelllang=en_us
set spellcapcheck=

" Skip irritating "press ENTER" prompt in many situations.
set shortmess=at

" When joining (J), don't put two spaces after sentence-ending punctuation.
set nojoinspaces

" Auto-save when losing focus (and don't bug me about external edits).
" au FocusLost * :wa <DISABLED FOR CAUSING 'press ENTER'>
set autowrite
set autoread

" Resize splits when the window is resized.
au VimResized * exe "normal! \<c-w>="

" Omnicompletion.
let g:SuperTabDefaultCompletionType = "context"

" Wildmenu: exploring files (incl. with Lusty).
set wildmode=list:longest
set wildignore+=*.o,*.aux,*.bbl,*.blg,*.log
set wildignore+=*.pyc,*.pyo,*.luac
set wildignore+=.DS_Store
set wildignore+=.hg,.git,.svn
set wildignore+=*.orig

" :sb, :sbnext, :sbprev will look in other tabs/windows.
set switchbuf=usetab

" Kill empty buffers (created when using --remote-silent). Unfortunately, this
" leaves the buffer numbering starting at 2, but too bad!
function KillEmptyBuf()
    for b in range(1, bufnr('$'))
        if bufloaded(b) && b != bufnr('%') && bufname(b) == ''
            execute "bw " . b
        endif
    endfor
endfunction
augroup killemptybuf
    autocmd!
    autocmd BufEnter * :call KillEmptyBuf()
augroup END

" Highlight VCS conflict markers.
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Treat buffers from stdin (e.g.: echo foo | vim -) as scratch buffers.
" https://twitter.com/dotvimrc/status/434395900748648448
au StdinReadPost * :set buftype=nofile

" }}}
" Searching. {{{
set incsearch
set ignorecase
set smartcase
set hlsearch
" Clear search highlight with \ .
noremap <leader><space> :noh<cr>:call clearmatches()<cr>
" Stay here on star.
" https://twitter.com/dotvimrc/status/428208518487764992
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
" Quickfix window for current search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
" }}}
" Line Return {{{
" Return to the line you were on before when reopening a file, but not in
" git commit messages.

function CursorReturn()
    if &filetype == "gitcommit"
        call setpos('.', [0, 1, 1, 0])
    else
        if line("'\"") > 0 && line("'\"") <= line("$") |
            execute 'normal! g`"zvzz' |
        endif
    endif
endfunction

augroup line_return
    au!
    au BufReadPost * call CursorReturn()
augroup END

" }}}
" Project-specific style overrides. {{{
autocmd BufNewFile,BufRead */llvm/* setlocal sw=2 ts=2 sts=2
autocmd BufNewFile,BufRead */python-musicbrainz-ngs/* setlocal noexpandtab
autocmd BufNewFile,BufRead */enerc/*.cpp,*/enerc/*.h setlocal sw=2 ts=2 sts=2
autocmd BufNewFile,BufRead */passert-llvm/*.cpp,*/passert-llvm/*.h
    \ setlocal sw=2 ts=2 sts=2
" }}}
" Backups/swapfiles. {{{
if exists('%undofile')
    set undofile " Persistent undo!
    set undoreload=10000
    set undodir=~/.vim/tmp/undo//
end
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set noswapfile
" }}}
" Filetypes. {{{

" Scala
augroup ft_scala
    au!
    autocmd FileType scala setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Ruby
augroup ft_ruby
    au!
    autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Shell
augroup ft_sh
    au!
    autocmd FileType sh setlocal wrap linebreak textwidth=0
augroup END

" Vim
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END

" Filetypes for prose writing.
augroup ft_markdown
    au!
    autocmd FileType markdown setlocal wrap linebreak textwidth=0 showbreak=
    autocmd FileType markdown setlocal makeprg=open\ -a\ Marked\ %
    autocmd FileType markdown nnoremap <leader>m :silent make\|redraw!<CR>
augroup END

" LaTeX types.
" (Leads to *much* better syntax highlighting and spell-checking.)
" (Also keybindings for `make` and `make view`.
let g:tex_flavor='latex'
let g:tex_comment_nospell=1
" LaTeX spelling rules.
function! TeXSettings()
    syn region texZone start="\\begin{lstlisting}"
        \ end="\\end{lstlisting}\|%stopzone\>" contains=@NoSpell
    syn region texZone start="\\texttt{"
        \ end="}\|%stopzone\>" contains=@NoSpell
    syn region texZone start="\\begin{tabular}{"
        \ end="}\|%stopzone\>" contains=@NoSpell
    syn region texZone start="\\citeauthor{"
        \ end="}\|%stopzone\>" contains=@NoSpell
    syn region texZone start="\\bibliographystyle{"
        \ end="}\|%stopzone\>" contains=@NoSpell
endfunction
augroup ft_tex
    au!
    autocmd FileType tex :call TeXSettings()

    " Word count.
    autocmd FileType tex nnoremap <leader>w :w !detex \| wc -w<CR>
    autocmd FileType tex vnoremap <leader>w :w !detex \| wc -w<CR>

    " Make.
    " TODO: I'd like makeprg to silent make's stderr (extra line output when a
    " command fails), but 2>/dev/null doesn't do the trick since vim overrides
    " it to capture that output.
    autocmd FileType tex setlocal makeprg=make\ -s\ QUIET=1
    autocmd FileType tex noremap <Leader>m :silent make\|redraw!\|cc<CR>
    autocmd FileType tex noremap <Leader>r :silent make view\|redraw!\|cc<CR>
    autocmd FileType tex setlocal errorformat=%f:%l:\ %m

    " Skim line sync.
    autocmd FileType tex noremap <buffer> <silent> <leader>s :silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf %<CR>"
augroup END

" Building Java with ant.
augroup ft_java
    au!
    autocmd FileType java setlocal efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
    autocmd FileType java setlocal makeprg=ant
augroup END

" Python
augroup ft_python
    au!
    au FileType python setlocal define=^\s*\\(def\\\\|class\\)
    au FileType python compiler pyunit
    au FileType python setlocal makeprg=nosetests
    au BufNewFile,BufRead */test_*.py setlocal makeprg=nosetests\ %
augroup END

" Go
augroup ft_go
    autocmd FileType go setlocal noexpandtab sw=4 ts=4 softtabstop=4
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
augroup END

" Julia
augroup ft_julia
    au!
    autocmd FileType julia setlocal sw=2 ts=2 softtabstop=2
augroup END

" LLVM assembly
augroup ft_llvm
  au! BufRead,BufNewFile *.ll set filetype=llvm
augroup END

" }}}
" Shortcuts/bindings. {{{

" Selection replace.
vmap r "_dP

" Easier linewise reselect what was just pasted.
nnoremap <leader>V V`]

" Sudo write with w!!.
cmap w!! w !sudo tee % >/dev/null

" Y should work like D or C (by default yanks the whole line).
nnoremap Y y$

" Jumping/movement.
" Center screen when using position history list.
nnoremap g; g;zz
nnoremap g, g,zz
" Emacsy jumping in insert mode.
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
" ... and command line.
cnoremap <c-a> <home>
cnoremap <c-e> <end>
" Screen lines by default.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Alternative to exit insert.
inoremap jk <ESC>

" Quicklist advance like search advance.
nnoremap <leader>n :cnext<CR>

" Don't need shift for ed commands.
nnoremap ; :

" An incredibly common typo.
command W w

" No shift for alternate buffer.
" FIXME It would be great if :A always added to the buffer list in a way that
" lusty-juggler could see.
nnoremap <leader>a :A<CR>

" }}}
" PEP-8 compliant indentation for Python docstrings. {{{
" Based on:
" http://stackoverflow.com/questions/4027222/vim-use-shorter-textwidth-in-comments-and-docstrings/4028423#4028423
function! GetPythonTextWidth()
    if !exists('g:python_normal_text_width')
        let normal_text_width = 79
    else
        let normal_text_width = g:python_normal_text_width
    endif

    if !exists('g:python_comment_text_width')
        let comment_text_width = 72
    else
        let comment_text_width = g:python_comment_text_width
    endif

    let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    if cur_syntax == "Comment"
        return comment_text_width
    elseif cur_syntax == "String" || cur_syntax == "Constant"
        " Check to see if we're in a docstring
        let lnum = line(".")
        let line_syntax = synIDattr(synIDtrans(synID(lnum, col([lnum, "$"]) - 1, 0)), "name")
        while lnum >= 1 && (line_syntax == "String" || line_syntax == "Constant" || match(getline(lnum), '\v^\s*$') > -1)
            if match(getline(lnum), "\\('''\\|\"\"\"\\)") > -1
                " Assume that any longstring is a docstring
                return comment_text_width
            endif
            let lnum -= 1
        endwhile
    endif

    return normal_text_width
endfunction
augroup pep8
    au!
    autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
augroup END

" }}}
" Steve Losh's shell command opens the result in a new buffer. {{{
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell
" }}}

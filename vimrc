" Plug! {{{

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/bundle')
Plug 'altercation/vim-colors-solarized'
Plug 'sampsyo/autolink.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/a.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-scripts/camelcasemotion'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
Plug 'vim-scripts/Zenburn'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'juvenn/mustache.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'
Plug 'JuliaLang/julia-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'ctrlpvim/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPBuffer'] }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'alunny/pegjs-vim', { 'for': 'pegjs' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'neomake/neomake'
Plug 'lepture/vim-jinja'
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'jremmen/vim-ripgrep'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'sampsyo/bril', { 'for': 'bril', 'rtp': 'bril-vim' }
Plug 'cucapra/futil', { 'for': 'futil', 'rtp': 'tools/vim/futil' }
Plug 'ruanyl/vim-gh-line'
call plug#end()

" }}}
" Plugins. {{{

" Leader key: use either \ or ,.
let mapleader = ","
nmap \ ,

" Vimpager.
let vimpager_use_gvim = 1

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

" Wildmenu: exploring files (incl. with CtrlP).
set wildmode=list:longest
set wildignore+=*.o,*.aux,*.bbl,*.blg,*.log
set wildignore+=*.pyc,*.pyo,*.luac
set wildignore+=.DS_Store
set wildignore+=.hg,.git,.svn
set wildignore+=*.orig
set wildignore+=*.pdf,*.jpg,*.zip

" CtrlP.
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>k :CtrlPBuffer<CR>
let ignore_pats = split(&wildignore, ",")
call map(ignore_pats, '"-x " . shellescape(v:val)')
let git_exclude = join(ignore_pats, " ")
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git',
             \ 'git --git-dir=%s/.git ls-files -oc --exclude-standard ' .
             \ git_exclude],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
    \ 'fallback': 'find %s -type f'
    \ }

" bufkill.
nnoremap <leader>x :BD<CR>
let g:BufKillCreateMappings = 0

" Airline.

" Signify (hg/git diff in the gutter).
let g:signify_disable_by_default = 1
nnoremap <leader>d :SignifyToggle<CR>

" Asterisk.
" Make "z" (stay) behavior the default.
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
" Keep the cursor in the same relative position.
let g:asterisk#keeppos = 1

" Neomake.
call neomake#configure#automake('rw')
let g:neomake_python_enabled_makers = ['flake8', 'python']
let g:neomake_python_python_exe = 'python3'
let g:neomake_tex_enabled_makers = ['rubber']
let g:neomake_rust_enabled_makers = []

" Merlin for OCaml
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Markdown.
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 0  " New list items at same level.

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
set showcmd " see <Leader>
set smoothscroll

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
set showbreak=~

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

" Omnicompletion.
let g:SuperTabDefaultCompletionType = "context"

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

" Dash.
nnoremap <leader>d :Dash<CR>

" When closing windows, don't resize too disruptively.
" http://stackoverflow.com/q/486027
set equalalways

" Folds, based on syntax and open by default.
set foldmethod=syntax
set foldlevelstart=20

" }}}
" Searching. {{{
set incsearch
set ignorecase
set smartcase
set hlsearch
" Clear search highlight with \ .
noremap <leader><space> :noh<cr>:call clearmatches()<cr>
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
autocmd BufNewFile,BufRead */Notes/*.txt setlocal filetype=markdown
autocmd BufNewFile,BufRead *-review*.txt setlocal filetype=markdown
" }}}
" Backups/swapfiles. {{{
if isdirectory($HOME . '/.vim/tmp') == 0
    :silent !mkdir -p ~/.vim/tmp > /dev/null 2>&1
endif
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
    autocmd FileType markdown setlocal wrap linebreak textwidth=0
    autocmd FileType markdown setlocal showbreak=NONE breakindent
    autocmd FileType markdown setlocal makeprg=open\ -a\ 'Marked\ 2'\ %
    autocmd FileType markdown nnoremap <leader>m :silent make\|redraw!<CR>
augroup END

" TaskPaper.
augroup ft_taskpaper
    au!
    autocmd FileType taskpaper setlocal wrap linebreak textwidth=0 showbreak=NONE
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

    " Disable auto-indent, which can be infuriating for TeX.
    autocmd FileType tex setlocal nosmartindent
    autocmd FileType tex setlocal nocindent
    autocmd FileType tex setlocal indentexpr=

    " Soft wrap!
    autocmd FileType tex setlocal wrap linebreak textwidth=0 showbreak=NONE

    " Enable spell checking, even when it's a partial TeX file.
    autocmd FileType tex syntax spell toplevel
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
    au FileType python compiler flake8
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

" reStructuredText (really, Sphinx)
function! OpenSphinxPage()
  let sphinxbase = fnamemodify(findfile("conf.py", ".;"), ':h:p')
  let sphinxbase = fnamemodify(sphinxbase, ':p')
  let curfile = expand('%:p')
  let suffix = curfile[len(sphinxbase):]
  let htmlfile = sphinxbase . '_build/html/' .
        \ substitute(suffix, "\.rst$", ".html", "")
  call netrw#NetrwBrowseX(htmlfile, 0)
endfunction
augroup ft_rst
  au!
  autocmd FileType rst noremap <Leader>r :call OpenSphinxPage()<CR>
augroup END

" TypeScript
augroup ft_typescript
    au!
    autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" webppl
augroup ft_webppl
  au! BufRead,BufNewFile *.wppl set filetype=javascript
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

" Don't require a shift press to get the alternate buffer.
nnoremap <leader>a :A<CR>

" Look up a line on GitHub.
" https://gist.github.com/callahanrts/9274ad952b3e79cccc44
function! ShowOnGithub()
  let u = system("echo ${${${$(git --git-dir=.git config --get remote.origin.url)#git@github.com:}%.git}#https://github.com/} | xargs echo -n")
  silent exec "!open "."https://github.com/".u."/blob/master/".@%.'\#L'.line(".")
endfunction
command! -nargs=0 ShowOnGithub call ShowOnGithub()
nnoremap <Leader>gh :ShowOnGithub<CR>

" Switch to the last buffer *slightly* faster with \j.
nnoremap <leader>j :b#<cr>

" Use the most recent search for global replacement.
" http://howivim.com/2016/damian-conway/
nnoremap <expr> <leader>r  ':%s/' . @/ . '//g<LEFT><LEFT>'

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
" Reload spelling when it changes. {{{
" https://vi.stackexchange.com/a/5052/9520
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') ||
                \ getftime(d) > getftime(d . '.spl'))
        exec 'silent mkspell! ' . fnameescape(d)
    endif
endfor
" }}}
" Notes window. {{{
if v:servername == 'NOTES'
    cd "~/Dropbox/Notes"
    echo "This does not seem to work."
endif
" }}}

# All the paths I wish I had.
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=~/Library/Python/3.12/bin:$PATH
export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PATH=~/.rsrc/bin:$PATH
export PATH=$PATH:~/.ec2/bin:~/.cabal/bin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/usr/bin/vendor_perl
export PATH=$PATH:/usr/texbin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/sbin:/sbin
export PATH=$PATH:~/.node_modules/bin
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH

# Homebrew path.
if [ -d /opt/homebrew ] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export EDITOR=vim
export PYTHONSTARTUP=~/.pystartup

# Ruby gem path.
if which ruby >/dev/null 2>&1 && which gem >/dev/null 2>&1; then
    # The proper way, which is really slow:
    # PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
    # A hacky shortcut:
    if [ -d ~/.gem/ruby ] ; then
        for binpath in $( ls -d ~/.gem/ruby/*/bin ) ; do
            export PATH=$binpath:$PATH
        done
    fi
    if [ -d ~/.local/share/gem/ruby ] ; then
        for binpath in $( ls -d ~/.local/share/gem/ruby/*/bin ) ; do
            export PATH=$binpath:$PATH
        done
    fi
fi

# LaTeX path.
if [ -d /usr/local/texlive ] ; then
    for binpath in $( ls -d /usr/local/texlive/*/bin/* ) ; do
        export PATH=$binpath:$PATH
    done
fi

export MYSHELL=/bin/zsh

# Aliases.
alias p="ping 8.8.8.8"
alias t="tmux -u attach"
alias hs="hg st ."
alias vl=vimpager
alias unq="xattr -d com.apple.quarantine"  # Gatekeeper.
alias we="watchexec --no-meta"

# Shortcut for opening PDFs in Skim. (Not using `alias` make it possible to
# change autocompletion behavior in zsh.)
function skim()
{
    open -a skim $@
}

# Alias xdg-open to open.
if which xdg-open >/dev/null 2>&1 ; then
alias open="xdg-open"
fi

# Run additional profile chunks.
[ -f $HOME/.dotfiles_extra/profile.sh ] && . $HOME/.dotfiles_extra/profile.sh
[ -f $HOME/.profile_local ] && . $HOME/.profile_local

# Alias to gvim or mvim.
if which mvim >/dev/null 2>&1 ; then
    export GVIM=mvim
    alias vim="mvim -v"
else
    if [ -z "$DISPLAY" ] ; then
        export GVIM=vim
    else
        export GVIM=gvim
    fi
fi
alias v="$GVIM --remote-silent"

# A special window just for notes.
alias vn="$GVIM --servername notes --remote-silent"

# A fancy utility for opening the *visible* vim in a window manager (or opening
# a new one otherwise). This requires the `wmctrl` utility, which interacts
# with the WM to list windows and desktops. It uses a wrapper I wrote that
# finds a visible vim window (if any).
if which wmctrl >/dev/null 2>&1 ; then
unalias v
function v()
{
    vimserver=`visible_vim.py`
    if [ ! -z "$vimserver" ] ; then
        $GVIM --servername $vimserver --remote $@
    else
        $GVIM $@
    fi
}
fi

# Alias nose.
if which nosetests-2.7 >/dev/null 2>&1 ; then
alias nose=nosetests-2.7
else
alias nose=nosetests
fi

# Alias python2 & python on platforms without it.
if ! which python2 >/dev/null 2>&1 ; then
    alias python2=python
fi
if ! which python >/dev/null 2>&1 ; then
    alias python=python3
fi

# Find the Python file for a given module.
function pywhich()
{
    python -c "import $1; print($1.__file__)" | sed 's/\.py[co]$/.py/'
}

# wdiff with colors.
alias wdiffc="wdiff -w $'\033[30;41m' -x $'\033[0m' \
    -y $'\033[30;42m' -z $'\033[0m'"

# autossh. And AutoSshTmux sweet-spot combo.
export AUTOSSH_PORT=9017
export AUTOSSH_POLL=30
function ast()
{
    autossh $1 -t -- tmux -u attach
}

# Use ripgrep as an easy find replacement.
function rf()
{
    rg --files -g \*$@\*
}

# Convert PDF to SVG with Poppler.
function pdf2svg()
{
    for fn in $1
    do
        pdftocairo -svg $fn `basename $fn .pdf`.svg
    done
}

# OPAM configuration.
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Aliases for exa.
if which exa >/dev/null 2>&1 ; then
    alias lx="exa --classify --git"
elif which eza >/dev/null 2>&1 ; then
    alias lx="eza --classify --git"
fi
if lx >/dev/null 2>&1 ; then
    alias l="lx"
    alias ll="lx -l"
    alias lt="lx -l --sort newest"
else
    alias l="ls"
    alias ll="ls -l"
    alias lt="ls -ltr"
fi

# Shortcut for viewing. (`batcat` is Debian's name for it.)
if which bat >/dev/null 2>&1 ; then
    alias c=bat
elif which batcat >/dev/null 2>&1 ; then
    alias c=batcat
else
    alias c=less
fi

# z.
if which zoxide >/dev/null 2>&1 ; then
    eval "$(zoxide init zsh)"
elif [ -f ~/.rsrc/z.sh ]; then
    . ~/.rsrc/z.sh
    # Use normal cd-like completion for z (on zsh).
    if type compctl >/dev/null 2>&1; then
        compctl -/ _z
    fi
fi

# Debian's name for `fd`.
if which fdfind >/dev/null 2>&1 ; then
    alias fd=fdfind
fi

# GPG: why on earth is this necessary (why can't it just use `tty` itself)?
export GPG_TTY=`tty`

# git's colorful diff.
function giff () {
    git diff --no-index $@
}
function wiff () {
    giff --word-diff $@
}

# Tailscale CLI on macOS.
_tsapp=/Applications/Tailscale.app/Contents/MacOS/Tailscale
[ -f $_tsapp ] && alias tailscale=$_tsapp

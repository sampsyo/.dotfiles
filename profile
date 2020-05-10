# All the paths I wish I had.
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=~/Library/Python/3.7/bin:$PATH
export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PATH=~/.rsrc/bin:$PATH
export PATH=$PATH:~/.ec2/bin:~/.cabal/bin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/usr/bin/vendor_perl
export PATH=$PATH:/usr/texbin
export PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/sbin:/sbin
export PATH=$PATH:~/.node_modules/bin
export PATH=$PATH:~/.cargo/bin

export EDITOR=vim
export PINDIR=~/pin
export PYTHONSTARTUP=~/.pystartup

# Go path.
if which go >/dev/null 2>&1 ; then
    export GOPATH=$HOME/code/go
    export PATH=$PATH:`go env GOROOT`/bin:$GOPATH/bin
fi

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
fi

# LaTeX path.
if [ -d /usr/local/texlive ] ; then
    for binpath in $( ls -d /usr/local/texlive/*/bin/* ) ; do
        export PATH=$binpath:$PATH
    done
fi

export LUA_PATH="./?/init.lua;;"
export LUA_INIT="require 'luarocks.require'"

export MYSHELL=/bin/zsh

# Aliases.
alias p="ping 8.8.8.8"
alias t="tmux -u attach"
alias hs="hg st ."
alias vl=vimpager
alias unq="xattr -d com.apple.quarantine"  # Gatekeeper.
alias skim="open -a skim"

# Alias xdg-open to open.
if which xdg-open >/dev/null 2>&1 ; then
alias open="xdg-open"
fi

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

# Alias python2 on platforms without it.
if ! which python2 >/dev/null 2>&1 ; then
alias python2=python
fi

# Make chromium allow local AJAX.
alias chromium="chromium --allow-file-access-from-files"
# And also give it a shorter command.
alias chrome=chromium

# gnome-terminal should be xterm-256color but doesn't provide an option.
if [ "$COLORTERM" = "gnome-terminal" ]; then
    export TERM=xterm-256color
fi

# Find the Python file for a given module.
function pywhich()
{
    python -c "import $1; print $1.__file__" | sed 's/\.py[co]$/.py/'
}

# Fix "Open With" duplicate entries on OS X.
# http://www.leancrew.com/all-this/2013/02/getting-rid-of-open-with-duplicates/
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

# Run additional profile chunks.
[ -f $HOME/.dotfiles_extra/profile.sh ] && . $HOME/.dotfiles_extra/profile.sh
[ -f $HOME/.profile_local ] && . $HOME/.profile_local

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

# Convert PDF to SVG with Inkscape.
function pdf2svg()
{
    inkscape --without-gui --file=`pwd`/$1 --export-plain-svg=`pwd`/`basename $1 .pdf`.svg
}

# OPAM configuration.
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Aliases for exa.
alias lx="exa --classify --git"
alias lxl="lx -l"
alias lxt="lx -l --sort newest"
if which exa >/dev/null 2>&1 ; then
    alias l="lx"
else
    alias l="ls"
fi

export PATH="$HOME/.cargo/bin:$PATH"

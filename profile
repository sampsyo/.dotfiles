# All the paths I wish I had.
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/python:/usr/local/share/python3:/usr/local/share/pypy:$PATH
export PATH=~/.rsrc/bin:$PATH
export PATH=$PATH:~/.ec2/bin:~/.cabal/bin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/usr/bin/vendor_perl
export PATH=$PATH:/usr/texbin

export EDITOR=vim
export TEXINPUTS=$TEXINPUTS:~/Library/texmf
export PINDIR=~/pin
export PYTHONSTARTUP=~/.pystartup
# export MACOSX_DEPLOYMENT_TARGET=10.9  # Fix setuptools issues.
export JSR308=~/uw/jsr308
export CHECKERFRAMEWORK=~/uw/checker-framework

# Go path.
if which go >/dev/null 2>&1 ; then
    export GOPATH=$HOME/.go
    export PATH=$PATH:`go env GOROOT`/bin:$GOPATH/bin
fi

# Ruby gem path.
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
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

# Alias nose.
if which nosetests-2.7 >/dev/null 2>&1 ; then
alias nose=nosetests-2.7
else
alias nose=nosetests
fi

# Alias ack on ubuntu, where it's called something horrible.
if which ack-grep >/dev/null 2>&1 ; then
alias ack=ack-grep
fi

# Alias python2 on platforms without it.
if ! which python2 >/dev/null 2>&1 ; then
alias python2=python
fi

# Make chromium allow local AJAX.
alias chromium="chromium --allow-file-access-from-files"
# And also give it a shorter command.
alias chrome=chromium

# Gems in homebrew.
if which brew >/dev/null 2>&1 ; then
export GEM_HOME=$(brew --prefix)
fi

# gnome-terminal should be xterm-256color but doesn't provide an option.
if [ "$COLORTERM" = "gnome-terminal" ]; then
    export TERM=xterm-256color
fi

# JAVA_HOME
if [ -e /usr/libexec/java_home ]; then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

# Jikes
jikesbuild=~/uw/jikesrvm/dist
if [ -e $jikesbuild ]; then
    export JIKES=$jikesbuild/`ls $jikesbuild`
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

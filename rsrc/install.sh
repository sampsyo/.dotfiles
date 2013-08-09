#!/bin/bash
dotfiles=$HOME/.dotfiles
for fn in $( ls $dotfiles ) ; do
    if [ "${fn:0:1}" != "." ] && [ "${fn##*.}" != "orig" ] ; then
        src=$dotfiles/$fn
        dest=$HOME/.`echo "$fn" | sed 's/__/\//g'`
        [ -L $dest ] && continue

        if [ -e $dest ] ; then
        echo moving aside $dest
        mv $dest $dest.off
        fi

        echo linking $dest
        mkdir -p `dirname $dest`
        ln -s $src $dest
    fi
done

# Poor man's subrepos.
cd ~/.vim/bundle
[ -d vundle ] || git clone git://github.com/gmarik/vundle.git

echo 'remember:'
echo 'pip install hg-git'

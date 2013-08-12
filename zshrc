# Load antigen (zsh plugin/bundle manager).
source $HOME/.rsrc/antigen.zsh
antigen-lib  # oh-my-zsh base.
antigen-bundle git
antigen-bundle pip
antigen-bundle osx
antigen-bundle svn
antigen-bundle vi-mode
antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zsh-completions
antigen-bundle zsh-users/zsh-history-substring-search
antigen-apply

# Two-line prompt:
# PROMPT="%{$fg[green]%}%T %{$fg[green]%}%m %{$fg[green]%}%~
# %{$fg[green]%}▸ %{$reset_color%}"
# One-line prompt:
RPROMPT="%{$fg[green]%}%D{%L:%M:%S%p} %m:%~%{$reset_color%}"
PROMPT="%(!|%{$fg[red]%}#|%{$fg[green]%}▸) %{$reset_color%}"

# Backward search, like bash.
bindkey '^R' history-incremental-search-backward

# Just a few emacs bindings even though I'm using vi.
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Like modern vim, delete stuff even when I didn't just insert it.
bindkey -M viins '^?' backward-delete-char

# Failed wildcard matches should get passed through.
unsetopt nomatch

# Disable fucking bullshit history sharing. It's the worst, seriously.
unsetopt share_history

# Look on the FS every time for commands (avoid rehash).
unsetopt hash_cmds
unsetopt hash_dirs

# On Ubuntu, use command installation suggestions.
if [ -e /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# zmv
autoload -U zmv

# Keyboard bindings for zsh-history-substring-search.
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

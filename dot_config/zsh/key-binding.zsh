# Some key bindings from `Oh My Zsh`
# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Use emacs key bindings
bindkey -e

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
    bindkey "${terminfo[kend]}"  end-of-line
fi
# [Ctrl-e] Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-e' edit-command-line

# Some key bindings that don't need to autoload functions
bindkey '^[[3;5~' kill-word                   # [Ctrl-Delete] - delete whole forward-word
bindkey '^[[1;5C' forward-word                # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word               # [Ctrl-LeftArrow] - move backward one word
bindkey ' ' magic-space                       # [Space] - don't do history expansion
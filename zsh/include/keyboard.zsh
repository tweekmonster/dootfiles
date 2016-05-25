export KEYTIMEOUT=1
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/'

noop() {}
zle -N noop

autoload -U history-search-end

bindkey -v

bindkey -M vicmd '^s' toggle-sudo
bindkey -M viins '^s' toggle-sudo

bindkey -M viins '^R' history-incremental-search-backward

bindkey -M vicmd "\e[1;2D" noop
bindkey -M vicmd "\e[1;3D" noop
bindkey -M viins "\e[1;2D" noop
bindkey -M viins "\e[1;3D" noop

bindkey -M viins "\eb" backward-word
bindkey -M viins "\ew" forward-word

# Bound to ESC. There's no escape key sequence in my vi-mode
# this cancels vicmd mode and returns the curser to the end
bindkey -M vicmd '\e' vi-add-eol

bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^?' backward-delete-char
bindkey "\e?" backward-delete-char
bindkey '^w' backward-kill-word
bindkey "\e[3~" delete-char

# Note these are actual escape (0o033) characters
# Using iTerm2 with Esc+ and xterm defaults
bindkey "\e[A" history-beginning-search-backward-end
bindkey "\e[B" history-beginning-search-forward-end

function toggle-sudo() {
    local last_cmd="$(fc -l -n -1)"

    if [[ $BUFFER == $last_cmd ]]; then
        BUFFER=""
    else
        if [[ -z $BUFFER ]]; then
            BUFFER=$last_cmd
            CURSOR=${#BUFFER}
        fi

        # This cycles prefixing the buffer with sudo and sudo -s
        if [[ ${BUFFER:0:5} == "sudo " ]]; then
            if [[ ${BUFFER:0:8} == "sudo -s " ]]; then
                (( CURSOR-=8 ))
                BUFFER="${BUFFER:8:${#BUFFER}-8}"
            else
                BUFFER="sudo -s ${BUFFER:5:${#BUFFER}-5}"
                (( CURSOR+=3 ))
            fi
        else
            BUFFER="sudo ${BUFFER}"
            (( CURSOR+=5 ))
        fi
    fi

    if typeset -f _zsh_highlight > /dev/null; then
        _zsh_highlight
    fi
}

function reset-prompt() {
    # So prompt can be updated with vi-mode state
    zle .reset-prompt
}

zle -N toggle-sudo
zle -N zle-line-init reset-prompt
zle -N zle-keymap-select reset-prompt

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

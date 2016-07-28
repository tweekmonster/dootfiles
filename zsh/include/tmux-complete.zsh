# https://blog.plenz.com/2012-01/zsh-complete-words-from-tmux-pane.html
# https://github.com/mhinz/dotfiles/blob/fe54d9fec9915115355835de22556e38ac7a8b17/zsh/.zshrc#L434-L448
_tmux_complete() {
    [ -z $TMUX ] && { _message 'I double dare you!'; return 1 }
    local pane words=()
    for pane ($(tmux list-panes -F '#P')) {
        words+=( ${(u)=$(tmux capture-pane -Jpt $pane)} )
    }
    _wanted values expl '' compadd -a words
}
zle -C tmux-comp-prefix   complete-word _generic
zle -C tmux-comp-anywhere complete-word _generic
bindkey '^X^U' tmux-comp-prefix
bindkey '^X^X' tmux-comp-anywhere
zstyle ':completion:tmux-comp-(prefix|anywhere):*' completer _tmux_complete
zstyle ':completion:tmux-comp-(prefix|anywhere):*' ignore-line current-shown
zstyle ':completion:tmux-comp-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'

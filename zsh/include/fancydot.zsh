# Thanks @mhinz
# https://github.com/mhinz/dotfiles/blob/fe54d9fec9915115355835de22556e38ac7a8b17/zsh/.zshrc#L308-L326
fancy-dot() {
    local -a split
    split=( ${=LBUFFER} )
    local dir=$split[-1]
    if [[ $LBUFFER =~ '(^| )(\.\./)+$' ]]; then
        zle self-insert
        zle self-insert
        LBUFFER+=/
        [ -e $dir ] && zle -M $dir(:a:h)
    elif [[ $LBUFFER =~ '(^| )\.$' ]]; then
        zle self-insert
        LBUFFER+=/
        [ -e $dir ] && zle -M $dir(:a:h)
    else
        zle self-insert
    fi
}

zle -N fancy-dot
bindkey '.' fancy-dot

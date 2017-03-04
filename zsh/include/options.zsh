autoload -U compinit && compinit
zstyle ':completion:*' menu select

HISTSIZE=10000
SAVEHIST=10000

setopt cdablevars
setopt checkjobs
setopt completeinword
setopt correct
setopt globcomplete
setopt interactivecomments
setopt listpacked
setopt longlistjobs
setopt no_menucomplete
setopt no_autocd
setopt no_beep
setopt no_hist_beep
setopt no_listrowsfirst
setopt no_nomatch
setopt no_print_exit_value
setopt no_rm_star_silent
setopt nohup
setopt nolistambiguous
setopt nolog
setopt notify
setopt promptsubst
setopt append_history
setopt bang_hist
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt share_history

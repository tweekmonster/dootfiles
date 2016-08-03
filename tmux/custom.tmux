set-option -g status-position top

set -g status "on"

# Main bg bar
set -g status-bg "colour16"
set -g status-fg "colour255"
set -g status-attr "default"
set -g status-justify "left"

# These are the "tabs"
set -g window-status-bg "colour239"
set -g window-status-fg "colour255"

set -g window-status-activity-style "bold,italics"

set -g window-status-format "#[fg=colour255,bg=colour240] #F#I #[bg=colour236] #T #[bg=default]"
set -g window-status-current-format "#[fg=colour235,bg=colour68,bold] #F#I #[bg=colour247] #T #[bg=default]"

set -g status-left "#[bg=colour61]  #S  #[bg=default] "
set -g status-right "#(tmux -V) #(cat /dev/shm/tmuxstatus) #[fg=colour246,bg=default]  %Y-%m-%d %H:%M  #(echo $USER)@#h #S:#I:#P  "

#  vim: set ft=tmux ts=4 sw=4 tw=0 et :

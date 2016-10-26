set -g default-terminal "tmux-256color"
set -ag terminal-overrides ',*:Tc,*:sitm=\E[3m,*:ritm=\E[23m'
set-option -g mouse on

bind-key -T copy-mode-vi v send -X begin-selection
bind-key -T copy-mode-vi C-v send -X rectangle-toggle
if-shell 'hash sshclip-put 2>/dev/null' 'bind-key -T copy-mode-vi y send -X copy-pipe "sshclip-put -b"' 'bind-key -T copy-mode-vi y send -X  copy-selection'

bind-key -T root PPage if-shell -F "#{alternate_on}" "send-keys PPage" "copy-mode -e; send-keys PPage"
bind-key -T copy-mode-vi PPage send -X page-up
bind-key -T copy-mode-vi NPage send -X page-down
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
bind -n WheelDownPane select-pane -t= \; send-keys -M

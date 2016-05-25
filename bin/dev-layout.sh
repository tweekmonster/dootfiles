#!/bin/bash
panes=$(tmux list-panes | wc -l)
venv=${VIRTUAL_ENV##*/}
name=${venv:-$(tmux display -p "#W")}
name=${1:-$name}
size=${2:-100}

tmux rename-window $name

if [[ $panes -ge 4 ]]; then
  tmux resize-pane -x $size -t 2
fi

if [[ $panes -eq 1 ]]; then
  tmux splitw -h -l $size
  tmux splitw -t 2
  tmux splitw -t 2
  tmux select-pane -t 1
fi


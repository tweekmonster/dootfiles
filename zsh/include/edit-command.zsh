# Custom command line editor that sets the cursor position if $EDITOR is using
# Vim/Neovim.

edit-command-line() {
  tmpfile=$(mktemp -t zsheditXXXXXXXX.sh)
  print -R - "$PREBUFFER$BUFFER" > $tmpfile
  editor=${VISUAL:-${EDITOR:-vi}}
  args=()
  if [[ "$editor" =~ vim ]]; then
    pb=${#PREBUFFER}
    (( b=pb+CURSOR ))
    args+=("-c" ":call cursor(byte2line($b), ($b - $pb) + 1)")
  fi
  args+=($tmpfile)

  exec </dev/tty
  $editor ${args[@]}

  lines="$(wc -l $tmpfile | awk '{ print $1 }')"
  if [[ $lines -gt 1 ]]; then
    print -z - "$(<$tmpfile)"
    zle send-break
  else
    BUFFER="$(<$tmpfile)"
  fi
  command rm -f $tmpfile
  CURSOR="${#BUFFER}"
  if typeset -f _zsh_highlight > /dev/null; then
    _zsh_highlight
  fi
}

bindkey '^F' edit-command-line
zle -N edit-command-line

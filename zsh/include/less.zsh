export LESS=' -csR '

function hl() {
  # pygmentize needs to be installed, otherwise just use plain less.
  if (( ! $+commands[pygmentize] )); then
    less "$1"
    return $?
  fi

  if [[ -z "$1" ]]; then
    echo "No input file" >&2
    return 1
  fi

  if [[ ! -e "$1" ]]; then
    echo "File does not exist: $1" >&2
    return 1
  fi

  pygmentize -g -f terminal "$1" | less
}

man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[38;5;229m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[48;5;48;38;5;16m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[4;38;5;216m' \
    _NROFF_U=1 \
    man "$@"
}

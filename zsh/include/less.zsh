export LESS=' -R '

function hl() {
  # Don't set LESSOPEN globally since less could be used on very large files,
  # defeating less's ability to view them quickly.
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

  env LESSOPEN="| pygmentize -g -f terminal -l ${1:e} %s" less "$1"
}

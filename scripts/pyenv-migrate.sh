#!/usr/bin/env bash
# This script rebuilds my pyenv versions and virtualenvs in a new location
SEARCH="$HOME/.pyenv"
DEST="$HOME/.local/pyenv"

eval "$($DEST/bin/pyenv init -)"
eval "$($DEST/bin/pyenv virtualenv-init -)"

versions=($(pyenv completions install))
installed=($(pyenv versions --bare))

for p in "$SEARCH"/versions/*; do
  v=$(basename "$p")
  if [[ " ${installed[@]} " =~ " $v " ]]; then
    echo "Skip: $v"
    continue
  fi

  cd "$p/bin"
  if [[ " ${versions[@]} " =~ " $v " ]]; then
    pyenv install "$v"
  fi

  if [[ -L "$p" ]]; then
    pv=$(./python -V 2>&1 | awk '/Python/ { print $2 }')
    pyenv virtualenv "$pv" "$v"
    pyenv activate "$v"
    pip install -U pip
    ./pip freeze --local 2>/dev/null | pip install -r /dev/stdin
    pyenv deactivate
  fi
done

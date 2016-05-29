#!/usr/bin/env bash

prompt() {
  echo "Changing shell to zsh before continuing"
  chsh -s "$(which zsh)"
}

if ! hash zsh 2>/dev/null; then
  echo "Install zsh before continuing"
  exit 1
fi

test "${SHELL##*/}" = "zsh" || prompt

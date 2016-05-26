#!/usr/bin/env bash

prompt() {
  echo "Changing shell to zsh before continuing"
  chsh -s "$(which zsh)"
}

test "${SHELL##*/}" = "zsh" || prompt

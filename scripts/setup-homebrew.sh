#!/usr/bin/env bash
INSTALL=(
editorconfig
fzf
git
git-extras
htop
jq
pt
)

HEAD_INSTALL=(
tmux
)

BREW_BIN=""
if [[ "$(uname)" == "Darwin" ]]; then
  [[ ! -e "/usr/local/bin/brew" ]] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
elif [[ ! -e "$HOME/.linuxbrew/bin/brew" ]]; then
  if [[ "$(id -n -G)" == *sudo* ]]; then
    sudo apt-get install build-essential curl git python-setuptools ruby
  else
    echo "User can not run sudo commands" >&2
  fi
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)" < /dev/null
fi

if [[ "$(uname)" == "Darwin" ]]; then
  HEAD_INSTALL+=(neovim)
  BREW_BIN="/usr/local/bin/brew"
  export PATH="/usr/local/bin:$PATH"
else
  BREW_BIN="$HOME/.linuxbrew/bin/brew"
  export PATH="$HOME/.linuxbrew/bin:$PATH"
fi

env HOMEBREW_NO_ANALYTICS=1 $BREW_BIN install "${INSTALL[@]}"
env HOMEBREW_NO_ANALYTICS=1 $BREW_BIN install "${HEAD_INSTALL[@]}" --HEAD

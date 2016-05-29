zreload() {
  echo "Reloading shell"
  if [[ "$1" == "--clear" ]]; then
    zplug clear
    rm -f "$HOME/.zcompdump*"
  fi
  exec zsh -l
}


dootdoot() {
  cd "$DOTFILES"
  git fetch -p && git pull
  make install
}


upgrades() {
  (( $+commands[apt-get] )) && sudo apt-get update && sudo apt-get dist-upgrade
  brew update && brew upgrade
  pyenv update

  echo "Upgrading virtualenv pips"
  for v in "$PYENV_ROOT"/versions/*; do
    "$v/bin/pip" install -U pip
    name=$(basename "$v")
    [[ "$name" =~ "^neovim" ]] && "$v/bin/pip" install -U neovim
    [[ "$name" == "shell-utils" ]] && "$v/bin/pip" install -U flake8 isort pygments
  done
}

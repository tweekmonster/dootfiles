#!/usr/bin/env bash
export VIRTUAL_ENV_DISABLE_PROMPT=1
PYENV_ROOT="$HOME/.pyenv"

install_pyenv() {
  if [[ "$(uname)" == "Darwin" ]]; then
    brew install openssl readline
  else
    if [[ "$(id -n -G)" == *sudo* ]]; then
      sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev
    else
      echo "User can not run sudo commands" >&2
    fi
  fi
  curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
}

setup_envs() {
  export PATH="$HOME/.pyenv/bin:$PATH"
  export PYTHON_CONFIGURE_OPTS="--enable-shared"

  eval "$($PYENV_ROOT/bin/pyenv init -)"
  eval "$($PYENV_ROOT/bin/pyenv virtualenv-init -)"

  if [ ! -e "$PYENV_ROOT/versions/2.7.11" ]; then
    pyenv install 2.7.11
  fi

  if [ ! -e "$PYENV_ROOT/versions/3.4.4" ]; then
    pyenv install 3.4.4
  fi

  if [ ! -e "$PYENV_ROOT/versions/neovim2" ]; then
    pyenv virtualenv 2.7.11 neovim2
  fi

  if [ ! -e "$PYENV_ROOT/versions/neovim3" ]; then
    pyenv virtualenv 3.4.4 neovim3
  fi

  pyenv activate neovim2
  pip install -q -U pip neovim
  local py2=$("$PYENV_ROOT/bin/pyenv" which python)
  pyenv deactivate

  pyenv activate neovim3
  pip install -q -U pip neovim flake8 isort
  ln -s "$VIRTUAL_ENV/bin/flake8" "$HOME/bin/flake8" 2>/dev/null
  ln -s "$VIRTUAL_ENV/bin/isort" "$HOME/bin/isort" 2>/dev/null
  local py3=$("$PYENV_ROOT/bin/pyenv" which python)
  pyenv deactivate

  local vimrc="$HOME/.vimrc_local"
  local contents=$(cat "$vimrc")
  [[ -e "$vimrc" ]] && echo "$contents" | awk '!/g:python3?_host_prog/' > "$vimrc"
  cat <<EOF >> "$vimrc"
let g:python_host_prog = '$py2'
let g:python3_host_prog = '$py3'
EOF
}

[ ! -e "$PYENV_ROOT/bin/pyenv" ] && install_pyenv

setup_envs

#!/usr/bin/env bash
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.local/pyenv"

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
  export PATH="$PYENV_ROOT/bin:$PATH"
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

  if [ ! -e "$PYENV_ROOT/versions/shell-utils" ]; then
    pyenv virtualenv 3.4.4 shell-utils
  fi

  pyenv activate neovim2
  pip install -q -U pip neovim
  local py2=$("$PYENV_ROOT/bin/pyenv" which python)
  pyenv deactivate

  pyenv activate neovim3
  pip install -q -U pip neovim
  local py3=$("$PYENV_ROOT/bin/pyenv" which python)
  pyenv deactivate

  # Shell utlities
  pyenv activate shell-utils
  packages=("flake8" "isort" "pygments")
  links=("flake8" "isort" "pygmentize")
  pip install -q -U pip "${packages[@]}"
  for link in "${links[@]}"; do
    ln -fs "$VIRTUAL_ENV/bin/$link" "$HOME/bin/$link"
  done
  pyenv deactivate

  local nvim_python="$HOME/.config/nvim/.python.vim"
  mkdir -p "$(dirname $nvim_python)"
  cat <<EOF > "$nvim_python"
" This is generated.  Do not edit.
let g:python_host_prog = '$py2'
let g:python3_host_prog = '$py3'
EOF

  cat <<EOF >> zsh/_setup_zprofile.zsh
export PYENV_ROOT="$PYENV_ROOT"
export PATH="$PYENV_ROOT/bin:\$PATH"
EOF

  cat <<EOF >> zsh/_setup_zshrc.zsh
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF
}

[ ! -e "$PYENV_ROOT/bin/pyenv" ] && install_pyenv

setup_envs

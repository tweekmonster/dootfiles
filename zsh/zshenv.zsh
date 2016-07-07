script_base=$(dirname "${${(%):-%N}:A}")
export DOTFILES=$(dirname "$script_base")
export HOMEBREW_NO_ANALYTICS=1

export PYTHON_CONFIGURE_OPTS="--enable-shared"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/$USER}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"
export ZPLUG_HOME="$XDG_CONFIG_HOME/zplug"

export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonrc.py"

check_directories() {
  # Always create XDG_* directories and ensure they're accessible only to the
  # user.
  local parts item
  local statcmd="/usr/bin/stat -c '%a %n'"
  [[ $OSTYPE =~ "darwin" ]] && statcmd="/usr/bin/stat -f '%A %N'"

  for item in "$@"; do
    [[ ! -d "$item" ]] && mkdir -m 700 -p "$item"
  done

  local IFS=$'\n'
  for item in $(eval $statcmd "$@" 2>/dev/null); do
    parts=("${(@s: :)item}")
    if [[ "${parts[1]}" != '700' ]]; then
      echo "Fixing incorrect permissions (${parts[1]}) on ${parts[2]}" >&2
      chmod 700 "${parts[2]}"
    fi
  done
}

if [[ -z $ZSHENV_INIT ]]; then
  export ZSHENV_INIT=1

  check_directories \
    "$HOME/.ssh" \
    "$XDG_CONFIG_HOME" \
    "$XDG_CACHE_HOME" \
    "$XDG_DATA_HOME" \
    "$XDG_RUNTIME_DIR"

  if [[ -d "$HOME/.linuxbrew" ]]; then
    PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  fi

  export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.local/npm/bin:$PATH"
fi

# Ensure python virtualenv is activated if $VIRTUAL_ENV is set
export VIRTUAL_ENV_DISABLE_PROMPT=1
[[ -n $VIRTUAL_ENV && -e "$VIRTUAL_ENV/bin/activate" ]] && source "$VIRTUAL_ENV/bin/activate"


# FZF
export FZF_TMUX_HEIGHT=20
if hash pt 2>/dev/null; then
  export FZF_DEFAULT_COMMAND='pt -l -g ""'
fi


if hash nvim 2>/dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

[[ -e "$script_base/_setup_zshenv.zsh" ]] && source "$script_base/_setup_zshenv.zsh"
[[ -e "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"
unset script_base

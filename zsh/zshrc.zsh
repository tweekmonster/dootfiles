source "$ZPLUG_HOME/init.zsh"
script_base=$(dirname "${${(%):-%N}:A}")

zplug 'zplug/zplug'
zplug 'tj/git-extras'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'jamesob/desk', as:plugin, use:'shell_plugins/zsh'
zplug 'jamesob/desk', as:command, use:'desk'

if [[ -z $DOTFILES_SETUP ]]; then
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load
else
  # Running setup
  zplug install
  zplug load --verbose
fi

sources=(
'options'
'aliases'
'keyboard'
'edit-command'
'fancydot'
'tmux-complete'
'django-completions'
'less'
'dootfiles'
'pure'
)

for s in "${sources[@]}"; do
  source "$script_base/include/${s}.zsh"
done

unset s sources

# Let a local .zshrc override
[[ -e "$HOME/.zshrc_local" ]] && source "$HOME/.zshrc_local"

fzf_path="$HOME/.linuxbrew/opt/fzf"
if [[ $OSTYPE =~ "darwin" ]]; then
  source "$script_base/include/osx.zsh"
  fzf_path="/usr/local/opt/fzf"
fi

# FZF - I don't want the loose ~/.fzf.* scripts
if [[ -d "$fzf_path" ]]; then
  [[ $- == *i* ]] && source "$fzf_path/shell/completion.zsh" 2> /dev/null
  source "$fzf_path/shell/key-bindings.zsh"
fi

if [[ -e "$HOME/.dootfiles_install" ]]; then
  rm -f "$HOME/.dootfiles_install"
  hash -rf
fi

[[ -e "$script_base/_setup_zshrc.zsh" ]] && source "$script_base/_setup_zshrc.zsh"

# Ensure that the user bin directories are the first in PATH.  This results in
# duplicates.  It's okay.
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
unset script_base

nvim() {
  [[ -f "core" ]] && mv "core" "core-$(date +%s -r core)"
  $commands[nvim] "$@"
}

ulimit -c unlimited

# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

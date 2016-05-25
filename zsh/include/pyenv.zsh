# Holy shit oh-my-zsh's pyenv plugin can get slow calling on `brew`
pyenvdirs=("$HOME/.pyenv" "/usr/local/pyenv" "/usr/local/opt/pyenv" "/opt/pyenv")

workoncwd() {
  setopt local_options extended_glob
  venv=($(echo (../)#.venv(.N)))
  if [[ ${#venv} -gt 0 ]]; then
    new_venv=$(cat "${venv[-1]:a}")
    if [[ -n "$new_venv" ]]; then
      if pyenv prefix $new_venv >/dev/null 2>&1; then
        [[ "$new_venv" != "${VIRTUAL_ENV:t}" ]] && pyenv activate "$new_venv"
      fi
    fi
  fi
}

for pydir in "${pyenvdirs[@]}"; do
  if [[ -d "$pydir/bin" ]]; then
    export PYENV_ROOT="$pydir"
    export PATH="${pydir}/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    break
  fi
done

#!/usr/bin/env bash
[[ "$(lsb_release -is 2>/dev/null)" == "Ubuntu" ]] || exit 0

PACKAGES=("build-essential" "curl" "git" "python-setuptools" "software-properties-common" "ruby")
apt_install=()
for p in "${PACKAGES[@]}"; do
  dpkg -S "$p" >/dev/null 2>&1 || apt_install+=("$p")
done

if [[ "${#apt_install[@]}" -gt 0 ]]; then
  if [[ "$(id -n -G)" == *sudo* ]]; then
    sudo apt-get update
    sudo apt-get -y install "${apt_install[@]}"

    if [[ ! -e "/etc/apt/sources.list.d/neovim-ppa-unstable-$(lsb_release -sc).list" ]]; then
      sudo add-apt-repository -y ppa:neovim-ppa/unstable
      sudo apt-get update
      sudo apt-get -y install neovim
    fi
  else
    echo "There are packages that need to be installed, but you don't have sudo:" >&2
    echo "  ${apt_install[@]}" >&2
  fi
fi

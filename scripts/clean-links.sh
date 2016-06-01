#!/usr/bin/env bash
# Kind of an "uninstaller"
#
# Takes two arguments:
#   $1 - A search directory
#   $2 - A directory prefix
# $1 is searched for symlinks, and if it resolves to a file pointing to a file
# within $2, delete it.  The maximum depth of directories to search is 3.


# Get an absolute, normalized path
abspath() {
  if ! pushd `dirname $1` >/dev/null 2>&1; then
    # Bail because pushd failed
    echo "$1"
    return
  fi
  ret=$(pwd)
  popd > /dev/null
  echo "$ret/$(basename $1)"
}


# Joins path components, like Python's os.path.join()
joinpath() {
  path=""
  for p in "$@"; do
    if [[ "$p" =~ ^/ ]]; then
      path="$p/"
    else
      path+="$p/"
    fi
  done
  echo "${path%/}"
}


# Resolves a symlink.  Based on: http://stackoverflow.com/a/1116890/4932879
# This differs by not causing an infinite loop when a dead symlink is
# encountered, and the path components are joined correctly.
resolve() {
  local file="$1"
  cd $(dirname "$file")
  file=$(basename "$file")
  while [ -L "$file" ]; do
    file=$(readlink "$file")
    if ! cd "$(dirname "$file")" 2>/dev/null; then
      return
    fi
    file=$(basename "$file")
  done
  file=$(joinpath "$(pwd -P)" "$file")
  abspath "$file"
}


IFS=$'\n'
for link in $(find "$1" -maxdepth 3 -type l); do
  target=$(resolve "$link")
  if [[ "${target##$2/}" != "$target" ]]; then
    echo "unlink: $link -> $target"
    unlink "$link"
  fi
done

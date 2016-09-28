#!/usr/bin/env bash
VERSION="1.7.1"
DIST="linux"
BASE="$HOME/.local"
GOROOT="$BASE/go/${VERSION}"
GOPATH="$XDG_DATA_HOME/go"
TMPDIR="$BASE/gosetup"

# This is where my sources will live.
GODEV="$GOPATH/src/github.com/tweekmonster"

# This will simply be a symlink to $GODEV.
GODEVLINK="$HOME/dev/go"

if [[ ! -d "$GOROOT" ]]; then
  mkdir -p "$(dirname $GOROOT)"
  ext="tar.gz"
  if [[ "$(uname)" =~ Darwin ]]; then
    DIST='darwin'
    ext="pkg"
  fi

  mkdir -p "$TMPDIR/go"
  TMPFILE="$TMPDIR/go.${USER}.${ext}"
  curl -L "https://storage.googleapis.com/golang/go${VERSION}.${DIST}-amd64.${ext}" -o "$TMPFILE"

  if [[ "$DIST" == "darwin" ]]; then
    dir="$PWD"
    cd "$TMPDIR"
    xar -xf "go.${USER}.${ext}"
    cat com.googlecode.go.pkg/Payload | gunzip -dc | cpio -i
    mv "usr/local/go" "$GOROOT"
    cd "$dir"
  else
    tar zxf "$TMPFILE" -C "$TMPDIR/go" --strip-components=1
    mv "$TMPDIR/go" "$GOROOT"
  fi

  rm -rf "$TMPDIR"
fi

cat <<EOF >> zsh/_setup_zshenv.zsh
export GOPATH="$GOPATH"
export GOROOT="$GOROOT"
EOF

cat <<EOF >> zsh/_setup_zprofile.zsh
export PATH="$GOROOT/bin:$GOPATH/bin:\$PATH"
EOF

mkdir -p "$GODEV"
ln -s "$GODEV" "$GODEVLINK"

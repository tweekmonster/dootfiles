#!/usr/bin/env bash
VERSION="1.6.2"
DIST="linux"
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
GOROOT="$XDG_CACHE_HOME/go/${VERSION}"
TMPDIR="$XDG_CACHE_HOME/gosetup"

if [[ ! -d "$GOROOT" ]]; then
  mkdir -p "$(dirname $GOROOT)"
  ext="tar.gz"
  if [[ "$(uname)" =~ darwin ]]; then
    DIST='darwin'
    ext="pkg"
  fi

  mkdir -p "$TMPDIR/go"
  TMPFILE="$TMPDIR/go.${USER}.${ext}"
  curl -L "https://storage.googleapis.com/golang/go${VERSION}.${DIST}-amd64.${ext}" -o "$TMPFILE"

  if [[ "$DIST" == "darwin" ]]; then
    dir="$PWD"
    cd "$TMPDIR"
    xar -xf "go.${ext}"
    cat com.googlecode.go.pkg/Payload | gunzip -dc | cpio -i
    mv "usr/local/go" "$GOROOT"
  else
    tar zxf "$TMPFILE" -C "$TMPDIR/go" --strip-components=1
    mv "$TMPDIR/go" "$GOROOT"
  fi

  rm -rf "$TMPDIR"
fi

cat <<EOF >> zsh/_setup_zshenv.zsh
export GOPATH="$HOME/dev/go"
export GOROOT="$GOROOT"
export PATH="\$GOROOT/bin:\$GOPATH/bin:\$PATH"
EOF

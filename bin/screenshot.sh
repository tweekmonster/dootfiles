#!/usr/bin/env bash

upload() {
  id=$(base64 /dev/urandom | tr -d '/+' | head -c 10)
  file="$id/screenshot.png"
  url="https://share.esdf.io/$file"
  cat /tmp/screenshot | ssh share.esdf.io "mkdir -p www/share/$id && cat - > www/share/$file"
  rm /tmp/screenshot
  echo -n "$url" | tee /dev/tty | pbcopy
  echo
}

screencapture -Wo /tmp/screenshot && upload

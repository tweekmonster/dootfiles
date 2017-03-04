#!/usr/bin/env bash
# Captures the output of a command and uploads it to my server.
# Usage: sprunge <command>
# If <command> is a regular file, it is uploaded with highlighting.
export STDOUT_FILE=$(mktemp -t "sprunge.XXXXXXXX")
echo ""

cmd="$@"

escape() {
  sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'
}

errline() {
  awk '{ print "<em>"$0"</em>" }'
}

upload() {
  cat | ssh share.esdf.io "mkdir -p www/share/$id && cat - > www/share/$file"
}

id=$(base64 /dev/urandom | tr -d '/+' | head -c 10)

if [[ $# -eq 1 && -f $1 ]]; then
  # Generated from: https://highlightjs.org/download/
  HIGHLIGHT='<link rel="stylesheet" href="/.highlight/styles/github-gist.css">
<script src="/.highlight/highlight.pack.js"></script>'
  cmd=$(basename "$1")
  CLASS=${cmd##*.}
  if [[ "$CLASS" == "html" ]]; then
    name=$(echo "$cmd" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+$//g' | tr A-Z a-z)
    file="$id/$name.html"
    cat "$1" | upload
    echo "https://share.esdf.io/$file"
    exit 0
  fi

  cat "$1" | escape > "$STDOUT_FILE"
else
  sh -l -c "$cmd" 1> >(tee >(escape >> "$STDOUT_FILE")) \
    2> >(tee >(escape | errline >> "$STDOUT_FILE") >&2)
fi

name=$(echo "$cmd" | iconv -t ascii//TRANSLIT | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+$//g' | tr A-Z a-z)
file="$id/$name.html"
url="https://share.esdf.io/$file"

{
  cat <<HTML
<!doctype html>
<style>
body {
  font-family: monospace;
  font-size: 14px;
}

.cmd {
  display: flex;
  padding: .5rem 0;
  outline: 1px dashed #ccc;
  background: #fdfdfd;
  margin-bottom: 10px;
}

.cmd span {
  display: inline-block;
  white-space: pre-wrap;
  word-break: break-word;
}

.cmd span:before {
  content: '$';
  display: inline-block;
  color: #ccc;
  width: 6ch;
  flex: 0 0 6ch;
  margin-right: 1ch;
  text-align: right;
}

em {
  color: #ff7373;
  font-style: normal;
}

.lines {
  display: inline-block;
  max-width: 100vw;
  padding: 0 ! important;
}

.lines > div {
  position: relative;
  counter-increment: line;
}

.lines > div > a {
  opacity: 0;
  text-decoration: none;
  position: absolute;
  top: 0;
  left: 0;
}

.lines > div > a:before {
  content: 'link';
  color: #fff;
  background: #62d0ff;
  padding: 0 1ch;
}

.lines > div:hover > code {
  background: #f3f3f3;
}

.lines code {
  display: flex;
  white-space: pre-wrap;
  word-break: break-word;
}

.lines code > span {
  display: inline-block;
  width: 100%;
}

.lines code:before {
  content: counter(line) '\00a0';
  display: inline-block;
  width: 6ch;
  flex: 0 0 6ch;
  color: #999;
  background: #f6f6f6;
  text-align: right;
  margin-right: 1ch;
  user-select: none;
  -moz-user-select: none;
  -webkit-user-select: none;
  -ms-user-select: none;
}

.lines code:hover a {
  visibility: visible;
}

:target {
  outline: 1px dashed #1f88a7;
  background: #d8f0f8;
}
</style>
<body>
<div class="cmd"><span>$cmd</span></div>
<div class="lines $CLASS">
HTML
  lnum=0
  while IFS= read -r line; do
    ((lnum++))
    echo "<div><a href=\"#L${lnum}\"></a><code><span id=\"L${lnum}\">${line}</span></code></div>"
  done < $STDOUT_FILE
  echo "</div></body>"
  if [ -n "$HIGHLIGHT" ]; then
    echo "$HIGHLIGHT"
    echo -n "<script>"
    echo -n "hljs.highlightBlock(document.querySelector('.lines'));"
    echo -n "</script>"
  fi
  rm $STDOUT_FILE
} | upload

echo
echo "URL: $url"

#!/usr/bin/env bash
# Captures the output of a command and uploads it to sprunge.us
# Usage: sprunge <command>
export STDOUT_FILE=$(mktemp -t "sprunge.XXXXXXXX")
echo ""

cmd="$@"
echo "$cmd"

sh -l -c "$cmd" 1> >(tee >(sed "s/^/out: /" >> "$STDOUT_FILE")) \
  2> >(tee tee >(sed "s/^/err: /" >> "$STDOUT_FILE") >&2)

echo
echo "URL:"

{
  echo "# Command: $@"
  echo
  cat $STDOUT_FILE
} | curl -sSF 'sprunge=<-' http://sprunge.us

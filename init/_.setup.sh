#!/usr/bin/zsh

setup_scripts="${ZDOTDIR}/init"
if [ -d "$setup_scripts" ] && [ -r "$setup_scripts" ] && [ -x "$setup_scripts" ]; then
  for i in "$setup_scripts"/*; do
    [ "${i##*.}" = zsh ] && [ -f "$i" ] && [ -r "$i" ] && $i
  done
fi

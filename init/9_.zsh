#!/bin/zsh

printfex() {
  printf "\033[32m>>> %s\033[m\n" "$1"
}

printfex "Rewrite DOT_SETUPED"
sed -i "" 's/export DOT_SETUPED=false/export DOT_SETUPED=true/' $ZDOTDIR/.zshenv

exec zsh

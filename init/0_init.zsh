#!/bin/zsh

printfex() {
  printf "\033[32m>>> %s\033[m\n" "$1"
}

# create symlink
TARGET=(".gitconfig" ".vim" ".tmux.conf" ".asdf.yml" ".alacritty.toml")
for i in $TARGET; do
  ! [ -h "$HOME"/$i ] && ln -siv "$ZDOTDIR"/.config/$i "$HOME"
done

# install essentials
if [ "$(uname -s)" = "Linux" ]; then
  sudo apt install -y -qq build-essential
fi

# install [zinit](https://github.com/zdharma-continuum/zinit)
if ! [ -d ~/.zinit ]; then
  git clone -q https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin"
fi

# * install [asdf](https://asdf-vm.com/)
# if ! [ -d ~/.asdf ]; then
#   git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
# fi
# . "$HOME/.asdf/asdf.sh"

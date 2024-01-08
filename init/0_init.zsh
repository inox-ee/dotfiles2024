#!/bin/zsh

printfex() {
  printf "\033[32m>>> %s\033[m\n" "$1"
}

# create symlink
TARGET=(".gitconfig" ".vim" ".tmux.conf" ".asdf.yml" ".alacritty.toml" ".mise.toml")
for i in $TARGET; do
  ! [ -h "$HOME"/$i ] && ln -siv "$ZDOTDIR"/.config/$i "$HOME"
done

# install essentials
if [ "$(uname -s)" = "Linux" ]; then
  eval "$DOT_PKG_MANAGER" update
  eval "$DOT_PKG_MANAGER" install "$DOT_PKG_MANAGER_OPT" build-essential
  # to install ruby >3.2.0
  eval "$DOT_PKG_MANAGER" install "$DOT_PKG_MANAGER_OPT" libssl-dev libyaml-dev
  # to install python
  eval "$DOT_PKG_MANAGER" install "$DOT_PKG_MANAGER_OPT" zlib1g-dev libffi-dev
fi

# install [zinit](https://github.com/zdharma-continuum/zinit)
if ! [ -d ~/.zinit ]; then
  git clone -q https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin"
fi

# install [jdx/mise](https://github.com/jdx/mise)
if ! whence -w mise; then
  curl https://mise.jdx.dev/install.sh | sh
  ~/.local/bin/mise --version
fi


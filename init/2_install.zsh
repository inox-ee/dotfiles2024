#!/bin/zsh

# install [starship](https://starship.rs/ja-jp/)
if ! whence -w starship; then
  curl -sS https://starship.rs/install.sh | sh
fi

# install [fzf](https://github.com/junegunn/fzf)
if ! [ -d $HOME/.fzf ]; then
  git clone -q --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  echo "\e[33m[WARNING] please enable fzf-keybinding and disable other settings.\e[m"
  $HOME/.fzf/install
  rm $HOME/.fzf.bash
  rm $HOME/.fzf.zsh
fi

# download vim color theme
mkdir -p ~/.vim/colors
(cd $ZDOTDIR/.config/.vim/colors && curl -s -O https://raw.githubusercontent.com/w0ng/vim-hybrid/master/colors/hybrid.vim)

# install trash-cli
whence -w pip3 && whence -w trash || pip3 install -q trash-cli

# install tree
if ! whence -w tree; then
    eval "$DOT_PKG_MANAGER" install "$DOT_PKG_MANAGER_OPT" tree
fi

# install expect (for `unbuffer` command)
if ! whence -w unbuffer; then
    eval "$DOT_PKG_MANAGER" install "$DOT_PKG_MANAGER_OPT" expect
fi

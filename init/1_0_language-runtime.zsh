#!/bin/zsh

# install pyenv
if ! whence -w pyenv; then
  git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
  (cd "$HOME"/.pyenv && src/configure && make -C src)
  export PYENV_ROOT=$HOME/.pyenv
  eval "$(pyenv init -)"
  pyenv install 3.12.1
  pyenv global 3.12.1
fi

# isntall pip
if ! whence -w pip3; then
  curl -s https://bootstrap.pypa.io/get-pip.py | python3
  echo $(pip3 --version)
fi

# install rbenv
if ! whence -w rbenv; then
  git clone -q https://github.com/rbenv/rbenv.git $HOME/.rbenv
  git clone -q https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
fi

# install go
if ! whence -w go; then
  os_type=$(uname -s)
  go_bin_path="go1.21.5.${os_type:l}"-"$(uname -m)".tar.gz
  go_bin_path="$(echo "$go_bin_path" | sed -e "s/x86_64/amd64/")"
  curl -sSOL https://golang.org/dl/"${go_bin_path}"
  sudo tar -C /usr/local -xzf "${go_bin_path}"
  rm -f "${go_bin_path}"
fi

# install nvm
if ! whence -w nvm; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm install node
  nvm install lts/*
  nvm alias default lts/*
  curl -o- https://yarnpkg.com/install.sh | bash
fi

# Setting some applications

# starship
export STARSHIP_CONFIG="$ZDOTDIR"/.config/starship.toml
eval "$(starship init zsh)"

# docker
if [ "$(uname -s)" = "Darwin" ]; then
  export DOCKER_HOST=unix://$HOME/.lima/docker_org/sock/docker.sock
fi

# fzf
[ -f $ZDOTDIR/.config/.fzf.zsh ] && source $ZDOTDIR/.config/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 60% --reverse --border'

# jdx/rtx
if [ -e "$HOME/.local/share/rtx" ]; then
  eval "$(~/.local/share/rtx/bin/rtx activate zsh)"
fi

# pipenv
export PIPENV_VENV_IN_PROJECT=true

# go
export GOPATH=$HOME/go

# google cloud sdk
export GCLOUDPATH=$HOME/.google-cloud-sdk

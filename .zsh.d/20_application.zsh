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

# jdx/mise
if [ -e "$HOME/.local/bin/mise" ]; then
  eval "$(~/.local/bin/mise activate zsh)"
fi

# pipenv
export PIPENV_VENV_IN_PROJECT=true

# go
export GOPATH=$HOME/go

# google cloud sdk
export GCLOUDPATH=$HOME/.google-cloud-sdk

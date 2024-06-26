# Aliases
if [ "$(uname)" = 'Darwin' ]; then
  alias ls='gls --group-directories-first --human-readable --color -F'
else
  alias ls='ls --group-directories-first --human-readable --color -F'
fi
alias ll='ls -la'
alias rm='echo "This is not the command you are looking for."; false'
alias ln='ln -iv'
alias cl='clear'

## VSCode
if [ "$(uname)" = 'Darwin' ]; then
  alias code='open -a "Visual Studio Code"'
fi

## Ruby
alias ber='bundle exec rails'
alias berspec='bundle exec rspec'
alias update-rbenv='cd ~/.rbenv && git pull && cd ~/.rbenv/plugins/ruby-build && git pull'

## Python
alias python='python3'

## git
alias gad='git add'
alias gada='git add .'
alias gcm='git commit -m'
alias gfe='git fetch --prune'
alias gps='git push origin HEAD'
alias gsw='git switch'
alias gswd='git switch develop'
alias grsa='git restore .'

# Marp <https://github.com/marp-team/marp-cli>
alias marp-npx='npx -y @marp-team/marp-cli@latest'
alias marp-docker='docker run -it --name=marp-docker --rm -v "$(pwd):/home/marp/app" -e MARP_USER=$(id -u):$(id -g) -e LANG="ja_JP.UTF-8" marpteam/marp-cli --allow-local-files'

#!/bin/zsh

## Zsh-Users
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

autoload -U colors
colors

# enable zsh default function
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 100
zstyle ':chpwd:*' recent-dirs-default yes

# zinit completion
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'
# ? comment out because they spend a little bit time to load
autoload -U compinit
compinit -u
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
# setopt complete_in_word
# zmodload -i zsh/complist

setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE="(pwd|l|l[sal]|clear|cl)"
setopt EXTENDED_HISTORY
setopt hist_ignore_dups     # 前と重複する行は記録しない
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_NO_STORE        # histroyコマンドは記録しない
function history-all { history -E 1 }
# zshaddhistory() {
#   local line=${1%%$'\n'}
#   local cmd=${line%% *}
#   [[ ${cmd} != (l|l[sal])
#         && ${cmd} != (m|man)
#         && ${cmd} != (pwd)
#         && ${cmd} != (cl|clear)
#   ]]
# }

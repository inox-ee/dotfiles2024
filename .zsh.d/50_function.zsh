autoload -Uz catch
autoload -Uz throw

function gittemplate() {
  local -A opthash
  zparseopts -D -A opthash -- -branch:

  if [[ -n "${opthash[(i)--branch]}" ]]; then
    echo "-s option : ${opthash[--branch]}"
  fi

  if [ $# -ne 2 ]; then
    echo "Specify a source Git repogitory and new project name"
    return
  fi

  {
    if [[ -n "${opthash[(i)--branch]}" ]]; then
      git clone -b ${opthash[--branch]} --depth 1 $1 $2 || throw 'NetworkException'
    else
      git clone --depth 1 $1 $2 || throw 'NetworkException'
    fi
    cd $2 || throw 'NotFoundException'
    echo "current directory: $(pwd) ok?(y/N): "; read -q || throw 'InvalidError'
    echo ""
    trash ./.git
    git init
    git add .
    git commit -m "Initial Commit"
    git log --oneline
    echo "done"
  } always {
    if catch '*'; then
      case $CAUGHT in
        (*)
          echo "error"
          ;;
      esac
    fi
  }
  return
}

function grepex() {
  grep -C 1 "$1" -rn ./ --exclude-dir={.venv,.git,node_modules,tmp,bin,vendor,log} --color="always"
}

function treeex() {
  tree -aFC -L 2 -I "\.DS_Store|\.git|node_modules|vendor\/bundle"
}

function docker-rm-dangling-img() {
  docker rmi $(docker images -f "dangling=true" -q)
}

function ssh_color() {
  # when tmux is awake
  if [[ -n $(printenv TMUX) ]] ; then
    # ===set bg===
    local pane_id=`tmux display -p '#{pane_id}'`
    local ssh_dist=`echo "$@" | awk '{for(i=1;i<=NF;i++) if($i ~ /(kw1|os5|os1|ku1|mt1|tk2|kj1|ms1|os7|ql1|lc2|lb3|lb4|lb5|lm5)/) print $i}' RS=' '`
    if [[ -n $ssh_dist ]]; then
        if [[ $ssh_dist =~ (ql1|lc2|lb3|lb4|lb5|lm5) ]]; then
            #tmux select-pane -P 'bg=#1E1405'
            tmux select-pane -P 'bg=#0b3621'
        else
            #tmux select-pane -P 'bg=#1E0000'
            tmux select-pane -P "bg=#360b23"
        fi
    fi
    tmux select-pane -T "$ssh_dist"
    # ===/set bg
    # ===set tmux pane-border===
    local pb_config=`tmux show-options -gv "pane-border-format"`
    local pb_config_ssh="$pb_config #(echo [$ssh_dist])"
    tmux set-option -p pane-border-format "$pb_config_ssh"
    # 通常通りコマンド続行
    command ssh $@
    # デフォルトの色設定に戻す
    tmux select-pane -t $pane_id -P 'default'
    tmux set-option -p pane-border-format "$pb_config"
  else
    command ssh $@
  fi
}

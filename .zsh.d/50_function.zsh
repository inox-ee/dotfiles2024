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
  grep -C 1 "$1" -rn ./ --exclude-dir={.git,node_modules,tmp,bin,vendor,log} --color="always"
}

function treeex() {
  tree -aFC -L 2 -I "\.DS_Store|\.git|node_modules|vendor\/bundle"
}

function docker-rm-dangling-img() {
  docker rmi $(docker images -f "dangling=true" -q)
}

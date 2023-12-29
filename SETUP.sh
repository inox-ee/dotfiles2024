#!/bin/sh

printfex() {
    printf "\033[32m>>> %s\033[m\n" "$1"
}

# precheck
while true; do
    printf "Do you want to execute dotfile-setup? (y/N) " >&2
    read -r yn
    case $yn in
    [Yy]*) break ;;
    [Nn]*) echo "Bye." && exit 0 ;;
    *) echo "Please answer Yy or Nn." ;;
    esac
done

if ! [ "$ZDOTDIR" ]; then
    printfex "Set \$ZDOTDIR" && exit 0
fi

os_type=$(uname -s)
if ! [ "$os_type" = "Linux" ] && ! [ "$os_type" = "Darwin" ]; then
    printfex "This dotfiles can apply to Linux or Mac(Darwin)"
    exit 0
fi

# update packages
update_pkg() {
    printfex "Setup package manager"
    if [ "$os_type" = "Linux" ]; then
        sudo sed -i.bak -e "s%http://\(jp\.\)*archive\.ubuntu\.com/ubuntu/%http://ftp.riken.go.jp/Linux/ubuntu/%g" /etc/apt/sources.list
        sudo apt update -y -qq
        if [ "$1" = true ]; then
            printfex "Upgrade packages"
            sudo apt upgrade -qq
        fi
    elif [ "$os_type" = "Darwin" ]; then
        sudo brew update -q
        if [ "$1" = true ]; then
            printfex "Upgrade packages"
            sudo brew upgrade -q
        fi
    fi
}

flg_do_upgrade=$1
update_pkg "$flg_do_upgrade"

# install zsh
install_zsh() {
    printfex "Install zsh"
    case "$os_type" in
    "Linux") sudo apt -qq -y install zsh ;;
    "Darwin") sudo brew install -q zsh ;;
    esac
}
type zsh >/dev/null 2>&1 || install_zsh

# setup zsh
printfex "Setup zsh"
[ "$SHELL" = "$(which zsh)" ] || chsh -s "$(which zsh)"
ZSHENV="$HOME/.zshenv"
if ! [ -f "$ZSHENV" ]; then
    printf "export ZDOTDIR=%s\nsource \$ZDOTDIR/.zshenv\n" "$ZDOTDIR" >"$ZSHENV"
fi

printfex "After restart terminal, please run SETUP.cont.zsh"

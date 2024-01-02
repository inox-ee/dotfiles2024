if [ "$(uname -s)" = "Darwin" ]; then
    export DOT_SEDOPT="-i"""
    export DOT_PKG_MANAGER="brew"
    export DOT_PKG_MANAGER_OPT="-q"
elif [ "$(uname -s)" = "Linux" ]; then
    export DOT_SEDOPT="-i"
    export DOT_PKG_MANAGER="sudo apt"
    export DOT_PKG_MANAGER_OPT="-y -qq"
fi

export DOT_SETUPED=true

#!/bin/zsh

set -e

# use [jdx/mise](https://github.com/jdx/mise)
eval "$(~/.local/bin/mise activate zsh)"
mise install

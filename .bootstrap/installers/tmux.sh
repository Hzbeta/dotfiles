#!/bin/bash

# this installer is for miscellaneous tools
# don't need to check if it's installed or not
function check_is_tmux_installed() {
    if ! command -v tmux &>/dev/null; then
        return 1
    fi
    return 0
}

# install pnpm
function install_tmux() {
    sudo apt install -y tmux
}
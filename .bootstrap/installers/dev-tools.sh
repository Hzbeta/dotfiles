#!/bin/bash

# this installer is for miscellaneous tools
# don't need to check if it's installed or not
function check_is_dev-tools_installed() {
    if ! command -v shellcheck &>/dev/null; then
        return 1
    fi
    return 0
}

# install pnpm
function install_dev-tools() {
    sudo apt install -y shellcheck
}
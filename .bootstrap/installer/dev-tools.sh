#!/bin/bash

# this installer is for miscellaneous tools
# don't need to check if it's installed or not
function check_is_dev-tools_installed() {
    return 1
}

# install pnpm
function install_dev-tools() {
    sudo apt install -y shellcheck
}

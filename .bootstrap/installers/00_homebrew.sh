#!/bin/bash

# this installer is for miscellaneous tools
# don't need to check if it's installed or not
function check_is_homebrew_installed() {
    if [ ! -d "/home/linuxbrew/.linuxbrew" ]; then
        return 1
    fi
    return 0
}

# install
function install_homebrew() {
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

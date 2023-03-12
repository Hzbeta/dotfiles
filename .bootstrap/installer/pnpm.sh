#!/bin/bash

# check if pnpm is installed
function check_is_pnpm_installed() {
    if [ ! -d "$HOME/.local/share/pnpm" ]; then
        return 1
    fi

    return 0
}

# install pnpm
function install_pnpm() {
    wget -qO- https://get.pnpm.io/install.sh | sh -
}

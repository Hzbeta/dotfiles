#!/bin/bash

# check if pnpm is installed
function check_is_pnpm_installed() {
    if [[ ! -d "$HOME/.local/share/pnpm" ]]; then
        return 1
    fi

    return 0
}

# install pnpm
function install_pnpm() {
    if ! cd ~; then
        log error "failed to cd to $HOME"
        exit 1
    fi
    wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(command -v bash)" bash -
}

#!/bin/bash

# check if zsh is installed
function check_is_zsh_installed() {
    if ! command -v zsh &>/dev/null; then
        return 1
    fi

    return 0
}

# install zsh
function install_zsh() {
    if ! sudo apt install -y zsh; then
        log error "zsh installation failed"
        return 1
    fi

    # activate zsh config
    if ! zsh -c "export ZSH_PROFILE_DEBUG=true && . ~/.zshenv && . ~/.zshrc"; then
        log error "activate zsh config failed"
        return 1
    fi

    # change default shell to zsh
    if ! sudo usermod -s "$(command -v zsh)" "$(whoami)"; then
        log error "change default shell to zsh failed"
        return 1
    fi
    
    return 0
}

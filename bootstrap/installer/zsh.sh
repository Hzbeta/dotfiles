#!/bin/bash

# check if zsh is installed
function check_is_zsh_installed() {
    if [ -z $(which zsh) ]
    then
        return 1
    fi

    return 0
}

# install zsh
function install_zsh() {
    sudo apt install -y zsh
    if [ $? -ne 0 ]
    then
        log error "zsh installation failed"
        return 1
    fi

    # change default shell to zsh
    chsh -s $(which zsh)
    if [ $? -ne 0 ]
    then
        log error "change default shell to zsh failed"
        return 1
    fi

    return 0
}
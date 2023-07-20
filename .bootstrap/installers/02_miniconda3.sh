#!/bin/bash

# check if conda is installed
function check_is_miniconda3_installed() {
    if [[ ! -d "$HOME/miniconda3" ]]; then
        return 1
    fi

    return 0
}

function install_miniconda3() {

    # get global internet info
    is_global_internet_available
    local is_global=$?

    # set miniconda repo
    local miniocnda_repo="https://repo.anaconda.com/miniconda"

    if [[ $is_global -ne 0 ]]; then
        miniocnda_repo="https://mirrors.bfsu.edu.cn/anaconda/miniconda"
    fi
    
    # download miniconda installer

    local miniconda_installer="Miniconda3-latest-Linux-x86_64.sh" # TODO support other platforms
    if [[ -f "/tmp/$miniconda_installer" ]]; then
        # delete the previous installer
        rm "/tmp/$miniconda_installer"
    fi
    wget $miniocnda_repo/$miniconda_installer -O "/tmp/$miniconda_installer"

    # install miniconda
    if ! bash "/tmp/$miniconda_installer" -b -p "$HOME/miniconda3"; then
        log error "failed to install miniconda"
        exit 1
    fi

    rm "/tmp/$miniconda_installer"

}

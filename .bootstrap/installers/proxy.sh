#!/bin/bash

# this installer is for proxy setting
# don't need to check if it's installed or not
function check_is_proxy_installed() {
    if [ -f ~/.condarc ] && [ -f ~/.pip/pip.conf ]; then
        return 0
    fi
    return 1
}

# install proxy
function install_proxy() {
    # use conda mirror
    if [ ! -f ~/.condarc ]; then
        local channels='
channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/main
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/r
  - https://mirrors.bfsu.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.bfsu.edu.cn/anaconda/cloud
  msys2: https://mirrors.bfsu.edu.cn/anaconda/cloud
  bioconda: https://mirrors.bfsu.edu.cn/anaconda/cloud
  menpo: https://mirrors.bfsu.edu.cn/anaconda/cloud
  pytorch: https://mirrors.bfsu.edu.cn/anaconda/cloud
  pytorch-lts: https://mirrors.bfsu.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.bfsu.edu.cn/anaconda/cloud
'
        echo "$channels" >~/.condarc
        log info "Added mirror channels to ~/.condarc file."

        if command -v conda &>/dev/null; then
            conda clean -i -y
        fi
    fi

    # use pip mirror
    if [ ! -f ~/.pip/pip.conf ]; then
        if [ ! -d ~/.pip ]; then
            mkdir -p ~/.pip
        fi
        local pip_conf='
[global]
index-url = https://mirrors.bfsu.edu.cn/pypi/web/simple
[install]
trusted-host = https://mirrors.bfsu.edu.cn
'
        echo "$pip_conf" >~/.pip/pip.conf
        log info "Added pip mirror to ~/.pip/pip.conf file."
    fi
}

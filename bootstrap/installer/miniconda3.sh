#!/bin/bash

# check if conda is installed
function check_is_miniconda3_installed() {
  if [ ! -d "$HOME/miniconda3" ]; then
    return 1
  fi

  return 0
}

function install_miniconda3() {

  # set miniconda repo
  miniocnda_repo="https://repo.anaconda.com/miniconda"
  is_global=$(is_global_internet_available)
  if [ $is_global -ne 0 ]; then
    miniocnda_repo="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda"
  fi

  # download miniconda installer

  miniconda_installer="Miniconda3-latest-Linux-x86_64.sh" # TODO support other platforms
  if [ -f "/tmp/$miniconda_installer" ]; then
    # delete the previous installer
    rm "/tmp/$miniconda_installer"
  fi
  wget $miniocnda_repo/$miniconda_installer -O "/tmp/$miniconda_installer"

  # install miniconda
  if ! bash "/tmp/$miniconda_installer" -b -p "$HOME/miniconda3"; then
    log error "failed to install miniconda"
    exit 1
  fi

  # if global internet is available, use mirror
  if [ $is_global -ne 0 ]; then

    # use conda mirror
    channels='
channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch-lts: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
'
    echo "$channels" >~/.condarc
    log info "Added mirror channels to ~/.condarc file."

    # use pip mirror
    if [ ! -d ~/.pip ]; then
      mkdir -p ~/.pip
    fi
    pip_conf='
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn
'
    echo "$pip_conf" >~/.pip/pip.conf
    log info "Added pip mirror to ~/.pip/pip.conf file."
  fi

  rm "/tmp/$miniconda_installer"

}

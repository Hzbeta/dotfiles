#!/bin/bash

[[ -e ~/.profile ]] && source ~/.profile

# load utils
if ! cd "$(chezmoi source-path)"; then
    echo -e "[\033[31mError\033[0m] failed to cd to $(chezmoi source-path)"
    exit 1
fi 

source ./bootstrap/utils/base.sh

# installation list
# the config.sh contains the modules list
# the first argument is the path to the chezmoi source-path
source ./bootstrap/utils/config.sh "$(pwd)"

is_need_confirm=true
while $is_need_confirm; do

    need_install_modules=()
    # ask for each module installation
    for module in "${cm_user_modules[@]}"; do
        # shellcheck source=/dev/null
        source "./bootstrap/installer/${module}.sh"
        if ! "check_is_${module}_installed"; then
            if confirm "$(log info "install ${module}?")"; then
                log info "${module} will be installed..."
                need_install_modules+=("${module}")
            fi
        fi
    done

    # do a final check

    if [ -z "${need_install_modules[*]}" ]; then
        is_need_confirm=false
    else
        log info "the following will be installed \u2193"
        for module in "${need_install_modules[@]}"; do
            log info "\u2713 $module"
        done
        if confirm "$(log info 'continue?')"; then
            is_need_confirm=false
        else
            log info "recheck..."
        fi
    fi

done

if [ -z "${need_install_modules[*]}" ]; then
    exit 0
fi

# base installation
sudo apt update
sudo apt upgrade -y
# install wget
check_is_wget_available

# install modules
for module in "${need_install_modules[@]}"; do
    if ! "install_${module}"; then
        log error "$module installation failed"
        exit 1
    fi
done

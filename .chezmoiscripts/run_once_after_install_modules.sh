#!/bin/bash

 # shellcheck source=/dev/null
[[ -e ~/.profile ]] && source ~/.profile

# check if chezmoi is installed
if ! command -v chezmoi &> /dev/null; then
    echo -e "\033[31m[Error]\033[0m chezmoi is not installed"
    exit 1
fi

# get the chezmoi source path
if ! chezmoi source-path &> /dev/null; then
    echo -e "\033[31m[Error]\033[0m failed to get chezmoi source path"
    exit 1
fi
chezmoi_source_path="$(chezmoi source-path)"

# load utils
# shellcheck source=/dev/null
source "$chezmoi_source_path/.bootstrap/utils/base.sh"

# installation list
# the config.sh contains the modules list
# the first argument is the path to the chezmoi source-path
# shellcheck source=/dev/null
source "$chezmoi_source_path/.bootstrap/utils/config.sh" "$chezmoi_source_path"

is_need_confirm=true
while $is_need_confirm; do

    need_install_modules=()
    declare cm_user_modules
    # ask for each module installation
    for module in "${cm_user_modules[@]}"; do
        # shellcheck source=/dev/null
        source "$chezmoi_source_path/.bootstrap/installers/${module}.sh"
        if ! "check_is_${module}_installed"; then
            if [ "$CM_INSTALL_MODULE" = "all" ] || [ "$CM_INSTALL_MODULE" = "test" ]; then
                need_install_modules+=("${module}")
            else
                if confirm "$(log info "install ${module}?")"; then
                    need_install_modules+=("${module}")
                fi
            fi
        fi
    done

    # do a final check
    if [ -z "${need_install_modules[*]}" ]; then
        is_need_confirm=false
    else
        if [ "$CM_INSTALL_MODULE" = "all" ] || [ "$CM_INSTALL_MODULE" = "test" ]; then
            is_need_confirm=false
        else
            log info "the following will be installed:"
            for module in "${need_install_modules[@]}"; do
                log info "$module"
            done
            if confirm "$(log info 'continue?')"; then
                is_need_confirm=false
            else
                log info "recheck..."
            fi
        fi
    fi

done

if [ -z "${need_install_modules[*]}" ]; then
    exit 0
fi

if [ "$CM_INSTALL_MODULE" = "test" ]; then
    log error "the following module installation failed!"
    log error "${need_install_modules[@]}"
    exit 1
fi

# base installation
sudo apt update
sudo apt install -y wget curl git

# install modules
for module in "${need_install_modules[@]}"; do
    if ! "install_${module}"; then
        log error "$module installation failed"
        exit 1
    fi
done

log info "installation finished"
exit 0
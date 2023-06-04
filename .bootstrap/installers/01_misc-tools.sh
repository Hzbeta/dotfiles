#!/bin/bash

# tools list
# we can use `exa,brew` to install `exa` with homebrew
tools_info_list=(
    shellcheck
    tmux
    'fzf,brew'
    'exa,brew'
    'fd,brew'
    'joshuto,brew'
)

# processing tools list
for i in "${!tools_info_list[@]}"; do
    # check if an installer is present
    if [[ ${tools_info_list[i]} == *,* ]]; then
        # append default installer
        tools_info_list[i]="${tools_info_list[i]}:default"
    else
        # add default installer
        tools_info_list[i]="${tools_info_list[i]},default"
    fi
done

# this installer is for miscellaneous tools
# don't need to check if it's installed or not
function check_is_misc-tools_installed() {
    
    activate_homebrew

    for tool_info in "${tools_info_list[@]}"; do
        tool="${tool_info%%,*}"
        if ! command -v "$tool" &>/dev/null; then
            return 1
        fi
    done
    return 0
}

# install
function install_misc-tools() {

    activate_homebrew

    for tool_info in "${tools_info_list[@]}"; do
        tool="${tool_info%%,*}"
        install_methods="${tool_info##*,}"
        for method in $(echo "$install_methods" | tr ':' '\n'); do
            if command -v "$tool" &>/dev/null; then
                break
            fi
            if [[ "$method" == "default" ]]; then
                method="$(get_package_manager "$(get_linux_distro)")"
                if [[ "$method" == "Unknown" ]]; then
                    log error "Unknown Linux Distro, please install $tool manually."
                    return 1
                fi
                $method "$tool" && break
            else
                if command -v "$method" &>/dev/null; then
                    "$method" install "$tool" && break
                fi

            fi
        done
        if ! command -v "$tool" &>/dev/null; then
            log error "failed to install $tool"
            return 1
        fi
    done
}

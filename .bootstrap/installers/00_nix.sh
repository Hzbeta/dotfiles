#!/bin/bash

# this installer is for miscellaneous tools
# don't need to check if it's installed or not
function check_is_nix_installed() {
    if [ ! -d "/nix" ]; then
        return 1
    fi
    return 0
}

# install
function install_nix() {

    local install_cmd
    install_cmd=$(get_package_manager "install")

    if ! $install_cmd coreutils tar xz-utils; then
        log error "install coreutils tar xz-utils failed"
        return 1
    fi

    if ! sh <(wget -qO- https://nixos.org/nix/install) --no-daemon --yes --no-modify-profile; then
        log error "install nix failed"
        return 1
    fi
    # shellcheck source=/dev/null
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
}

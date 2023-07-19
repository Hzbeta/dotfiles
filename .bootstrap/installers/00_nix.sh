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
    sh <(wget -qO- https://nixos.org/nix/install) --no-daemon --yes --no-modify-profile
    # shellcheck source=/dev/null
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
}

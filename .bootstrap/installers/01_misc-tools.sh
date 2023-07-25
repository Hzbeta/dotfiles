#!/bin/bash

# tools list
# we use `nix` to install tools
# if the tool command is different from the package name
# we use `tool,package` to specify the package name
tools_info_list=(
    'shellcheck'       # ShellCheck, a static analysis tool for shell scripts.               https://github.com/koalaman/shellcheck
    'tmux'             # tmux is a terminal multiplexer for Unix-like operating systems.     https://github.com/tmux/tmux
    'fzf'              # fzf is a general-purpose command-line fuzzy finder.                 https://github.com/junegunn/fzf
    'lsd'              # lsd is a modern replacement for ls.                                 https://github.com/lsd-rs/lsd
    'fd'               # fd is a simple, fast and user-friendly alternative to 'find'.       https://github.com/sharkdp/fd
    'joshuto'          # joshuto is a minimalistic file manager in rust.                     https://github.com/kamiyaa/joshuto
    'act'              # act allows you to run your GitHub Actions locally.                  https://github.com/nektos/act
    'dust,du-dust'     # dust is a more intuitive version of du in rust.                     https://github.com/bootandy/dust
    'duf'              # duf is a Disk Usage/Free Utility - a better 'df' alternative.       https://github.com/muesli/duf
    'btop'             # btop is a resource monitor - a better 'top' alternative.            https://github.com/aristocratos/btop
)    


# this installer is for miscellaneous tools
# don't need to check if it's installed or not
function check_is_misc-tools_installed() {

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

    if ! command -v nix-env &>/dev/null; then
        log warning "nix-env not found, please install nix first"
        return 1
    fi

    for tool_info in "${tools_info_list[@]}"; do
        tool="${tool_info%%,*}"
        nix_package="${tool_info##*,}"
        if [ "$nix_package" == "" ]; then
            nix_package="$tool"
        fi
        if ! command -v "$tool" &>/dev/null; then
            log info "installing $tool..."
            nix-env -iA nixpkgs."$nix_package"
        fi
        if ! command -v "$tool" &>/dev/null; then
            log error "failed to install $tool"
            return 1
        fi
    done
}

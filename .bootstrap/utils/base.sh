#!/bin/bash

# function to check whether can connect to the global internet
function is_global_internet_available() {
    if wget -T 3 -t 1 --spider https://www.google.com; then
        return 0
    else
        return 1
    fi
}

# Define the confirm function
function confirm() {
    while true; do
        read -rp "$1 [Y/n] " response
        response=${response:-Y}
        case "$response" in
        [yY])
            return 0
            ;;
        [nN])
            return 1
            ;;
        *)
            log error "please enter y or n."
            ;;
        esac
    done
}

# Define the echo function with status and color
# the status can be: info, warning, error
# the color will set to: green, yellow, red
function log() {
    local status=$1
    local message=$2
    local status
    case "$status" in
    info)
        status="\033[32m[Info]\033[0m"
        ;;
    warning)
        status="\033[33m[Warning]\033[0m"
        ;;
    error)
        status="\033[31m[Error]\033[0m"
        ;;
    *)
        status="\033[32m[Info]\033[0m"
        ;;
    esac
    echo -e "$status $message"
}

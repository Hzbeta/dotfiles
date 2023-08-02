# for debug
function debug_log() {
    [[ "${ZSH_PROFILE_DEBUG:-false}" == "true" ]] && echo -e "\033[32m[Info]\033[0m $1"
}

function is_zsh_profile_debug() {
    [[ "${ZSH_PROFILE_DEBUG:-false}" == "true" ]]
}

# distro
function get_linux_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo $ID | tr '[:upper:]' '[:lower:]'
    elif type lsb_release >/dev/null 2>&1; then
        echo "$(lsb_release -si)" | tr '[:upper:]' '[:lower:]'
    elif [[ -f /etc/lsb-release ]]; then
        . /etc/lsb-release
        echo $DISTRIB_ID | tr '[:upper:]' '[:lower:]'
    elif [[ -f /etc/debian_version ]]; then
        echo "debian"
    else
        echo "unknown"
    fi
}

function get_distro_icon() {
    local distro mode icon name
    distro="$(get_linux_distro)"
    mode=$1  # mode could be "icon" or "icon_name"

    case $distro in
    *ubuntu*)
        icon=""
        name="Ubuntu"
        ;;
    *debian*)
        icon=""
        name="Debian"
        ;;
    *centos*)
        icon=""
        name="CentOS"
        ;;
    *fedora*)
        icon=""
        name="Fedora"
        ;;
    *arch*)
        icon=""
        name="Arch"
        ;;
    *)
        icon=""
        name="Unknown"
        ;;
    esac
    if [[ "$mode" == "icon" ]]; then
        echo $icon
    elif [[ "$mode" == "icon_name" ]]; then
        echo "$icon $name"
    else
        echo "Usage: get_distro_icon <icon|icon_name>"
        return 1
    fi
}

# add completions to FPATH
function add_completions_to_fpath() {
    local completions_path="$1"
    
    if [[ -d "$completions_path" && ":$FPATH:" != *":$completions_path:"* ]]; then
        FPATH="$completions_path:${FPATH}"
        debug_log "completions added to FPATH from $completions_path"
    fi
}

debug_log "source utils.zsh"
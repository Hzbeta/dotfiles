# misc
alias cl='clear'

# chezmoi
alias czm='chezmoi'

# aria2c
alias aria2d='aria2c -s 8 -x 8 -k 1M -c' # aria2c download with 5 connections, 1M chunk size and continue download

# aria2c download without proxy
if command -v aria2c >/dev/null 2>&1; then
    function aria2dnp() {
        tmp_http_proxy=$http_proxy
        tmp_https_proxy=$https_proxy
        tmp_all_proxy=$ALL_PROXY

        unset http_proxy
        unset https_proxy
        unset ALL_PROXY

        aria2c -s 8 -x 8 -k 1M -c "$@"

        export http_proxy=$tmp_http_proxy
        export https_proxy=$tmp_https_proxy
        export ALL_PROXY=$tmp_all_proxy
    }
fi

# joshuto
# use Q to quit and cd to the last dir
if command -v joshuto >/dev/null 2>&1; then
    jo() {
        joshuto --output-file /tmp/joshutodir
        if [ $? -eq 101 ] && [ -f /tmp/joshutodir ]; then 
        LASTDIR=`cat /tmp/joshutodir`
        rm -f /tmp/joshutodir 2>/dev/null
        if [ -d "$LASTDIR" ]; then 
            cd "$LASTDIR"
        fi
        unset LASTDIR
        fi
    }
fi

# lsd
if command -v lsd >/dev/null 2>&1; then
    function lla() {
        lsd --header --long --all $@
    }
    compdef lla=lsd
    function lls() {
        lsd --header --long --total-size $@
    }
    compdef lls=lsd
    function llas() {
        lsd --header --long --all --total-size $@
    }
    compdef lls=lsd
fi
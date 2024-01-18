#!/bin/bash
function feedback {
    prev_val=$?
    while getopts "h" opt; do
        case $opt in
            h)	echo "Show a unicolor pane in fullscreen, based on last command exit code or given hex color"
                echo "Usage: feedback [HEX COLOR]"
                return 0;;
            *)	echo "invalid option '$opt'"
                    exit 1;;
            esac
        done
        shift $((OPTIND -1))
    if [[ -n $1 ]];then
        color="#$1"
    else
        if [[ $prev_val -eq 0 ]];then
            color="#3CA73A"
        else
            color="#B44444"
        fi
    fi
    convert -size 16x9 xc:$color jpg:- | feh -F - >& /dev/null
}

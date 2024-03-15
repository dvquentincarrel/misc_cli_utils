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
    _feedback $prev_val "$@"
}

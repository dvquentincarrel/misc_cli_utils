#!/bin/bash
if [[ $1 == '-h' ]] || [[ $# -lt 2 ]]; then
    echo 'usage: doat <TIME DESCRIPTION> COMMAND...'
    echo 'For time description, run:'
    echo 'info coreutils -n "Relative items in date strings"'
    exit $([[ $1 = -h ]])
fi
epoch=$(date -d "$1" +%s)
current=$(date +%s)

if ! command -v "$2" &>/dev/null; then
    echo -e "\x1b[31mError\x1b[m: \x1b[1m$2\x1b[m does not look like an executable or function"
    exit 1
fi

trap "stty echo; tput cnorm; echo ' (ABORTED)'; exit" INT
stty -echo; tput civis

while [[ $current < $epoch ]]; do
    printf "\x1b[G$(date -d @$((epoch - current - 3600)) +%T)"
    sleep 1
    current=$(date +%s)
done
printf "\x1b[G$(date -d @$((epoch - current - 3600)) +%T)\n"
stty echo; tput cnorm

shift
"$@"

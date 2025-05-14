#!/bin/bash
HELP_MSG="usage: rrg EXPR...
Search for files under the directory tree with occurences of all the
given expressions, sort of a 'recursive' grep."
INTERACTIVE=true
COLOR=always
VIMGREP='--vimgrep'

if [[ $1 =~ -(h|-help) ]]; then
    echo "$HELP_MSG"
    exit 0
elif [[ $1 =~ -(p|-print) ]]; then
    INTERACTIVE=false
    VIMGREP=
    COLOR=auto
fi

# Filter files to extract those that contain all the patterns
files=(.)
for expr in "$@"; do
    read -ra files < <(rg --with-filename --count -- "$expr" "${files[@]}" | cut -f1 -d:)
    if [[ ${#files[@]} = 0 ]]; then
        echo "No file matching all these expressions found."
        exit 1
    fi
done

# Re-run search to get all matching lines
result_lines=()
for expr in "$@"; do
    mapfile -O ${#result_lines[@]} result_lines < <(rg $VIMGREP --with-filename --color=$COLOR "$expr" "${files[@]}")
done

if $INTERACTIVE; then
    printf "%s" "${result_lines[@]}" | frg
else
    printf "%s" "${result_lines[@]}"
fi

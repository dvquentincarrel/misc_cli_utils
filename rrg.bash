#!/bin/bash
HELP_MSG="usage: rrg [-t FILETYPE] [-T FILETYPE] [-h] [-p] EXPR...
Search for files under the directory tree with occurences of all the
given expressions, sort of a 'recursive' grep.
  -p    only prints matching lines, instead of selecting them through fzf for vim
  -t    restrict search to the given filetypes
  -T    ignores files of the given type for the search"
INTERACTIVE=true
COLOR=always
VIMGREP='--vimgrep'

while getopts "hpt:T:" opt; do
    case $opt in
        h)  echo "$HELP_MSG"
            exit 0;;
        t)  ft="--type $(sed 's/,/ --type /g' <<< "$OPTARG")";;
        T)  FT="--type-not $(sed 's/,/ --type-not /g' <<< "$OPTARG")";;
        p)  INTERACTIVE=false
            VIMGREP=
            COLOR=auto;;
        *)  echo -e"invalid option '$opt'\n"
            echo "$helpmsg"
            exit 1;;
    esac
done

shift $(($OPTIND-1))

# Filter files to extract those that contain all the patterns
files=(.)
for expr in "$@"; do
    mapfile -t files < <(rg $ft $FT --with-filename --count -- "$expr" "${files[@]}" | cut -f1 -d:)
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

#!/bin/bash
HELP_MSG="usage: rrg [-d] [-t FILETYPE]... [-T FILETYPE]... [-h] [-p] EXPR...
Search for files under the directory tree with occurences of all the
given expressions, sort of a 'recursive' grep.
  -p    only prints matching lines, instead of selecting them through fzf for vim
  -t    restrict search to the given filetypes
  -T    ignores files of the given type for the search
  -d    outputs debug information"
INTERACTIVE=true
COLOR=always
VIMGREP='--vimgrep'
DEBUG=false
ft=()
FT=()

while getopts "dhpt:T:" opt; do
    case $opt in
        h)  echo "$HELP_MSG"
            exit 0;;
        d)  DEBUG=true;;
        t)  ft+=($OPTARG);;
        T)  FT+=($OPTARG);;
        p)  INTERACTIVE=false
            VIMGREP=
            COLOR=auto;;
        *)  echo -e"invalid option '$opt'\n"
            echo "$helpmsg"
            exit 1;;
    esac
done
shift $(($OPTIND-1))

# Convert types into rg flags
if [[ ${#ft[@]} != 0 ]]; then
    ft=$(printf -- "--type %s " "${ft[@]}")
fi

if [[ ${#FT[@]} != 0 ]]; then
    FT=$(printf -- "--type-not %s " "${FT[@]}")
fi

# Filter files to extract those that contain all the patterns
files=(.)
for expr in "$@"; do
    $DEBUG && echo rg $ft $FT --files-with-matches -- "$expr" "${files[@]}"
    mapfile -t files < <(rg $ft $FT --files-with-matches -- "$expr" "${files[@]}" | cut -f1 -d:)
    if [[ ${#files[@]} = 0 ]]; then
        echo "No file matching all these expressions found."
        exit 1
    fi
done

if $INTERACTIVE; then
    output_prg=frg
else
    output_prg=cat
fi

# Re-run search to get all matching lines
for expr in "$@"; do
    rg $VIMGREP --with-filename --color=$COLOR "$expr" "${files[@]}"
done | $output_prg

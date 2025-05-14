#!/bin/bash
HELP_MSG="usage: arg [-t FILETYPE]... [-T FILETYPE]... [-h] [-p] EXPR...
Search for files under the directory tree with occurences of any of the
given expressions.
  -p    only prints matching lines, instead of selecting them through fzf for vim
  -t    restrict search to the given filetypes
  -T    ignores files of the given type for the search"
INTERACTIVE=true
COLOR=always
VIMGREP='--vimgrep'
ft=()
FT=()

while getopts "dhpt:T:" opt; do
    case $opt in
        h)  echo "$HELP_MSG"
            exit 0;;
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

if $INTERACTIVE; then
    output_prg=frg
else
    output_prg=cat
fi

rg $VIMGREP $ft $FT --with-filename --color=$COLOR --file <(printf "%s\n" "$@") | $output_prg

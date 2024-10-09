#!/bin/env bash

cache_dir=${XDG_CACHE_DIR:-~/.cache}
if ! [[ -f $cache_dir/emojis.txt ]]; then
    echo "Emoji file not found. Downloading it..." 1>&2
    curl --silent https://www.unicode.org/Public/emoji/latest/emoji-test.txt > "$cache_dir"/emojis.txt
    echo "Emojis downloaded" 1>&2
fi

read -rd '' ed_script <<EOF
g/\(^#\|^$\)/d
g/[A-F0-9]\+ [A-F0-9]\+ /d
g/1F3F./d
g/unqualified/d
%s/^.*#//
%s/E[0-9.]*//
g/./p
EOF

output=$(ed "$cache_dir"/emojis.txt <<< "$ed_script" |
fzf |
awk '{print $1 } END {print "\n"}' ORS='')
if [[ $1 = -n ]]; then
    printf '%s' "$output"
else
    printf '%s' "$output" | xclip -sel clip
fi

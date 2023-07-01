#!/bin/bash
# Setup script, handles symlink creation

lbin=${1:-"$HOME/.local/bin"}
mkdir -p "$lbin"
files=$(find $PWD -type d -name '.git' -prune -o -type f -not -name 'setup.sh' -perm -100 -printf "%P\n")
for executable in $files; do
    ln -sv "$executable" "$lbin/$executable"
done

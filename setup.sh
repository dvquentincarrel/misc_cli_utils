#!/bin/bash
# Setup script, handles symlink creation

lbin=${1:-"$HOME/.local/bin"}
mkdir -p "$lbin"
for executable in tui_light locale_toggle; do
    ln -si "$PWD/$executable" "$lbin/$executable"
done

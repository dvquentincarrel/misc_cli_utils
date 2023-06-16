#!/bin/bash
# Setup script, handles symlink creation

lbin=${1:-"$HOME/.local/bin"}
mkdir -p "$lbin"
for executable in tui_light locale_toggle \
        yt_pl_lost_and_found yt_pl_parse; do
    ln -si "$PWD/$executable" "$lbin/$executable"
done

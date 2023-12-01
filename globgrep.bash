#!/bin/bash
# Grep, but with bash globbing patterns
if [[ $# -eq 0 ]]; then
    echo Usage: globgrep PATTERN
fi

if [[ $1 = '-c' ]]; then
    clr="--color=always"
    shift
else
    clr="--color=never"
fi

pattern=${1//\*/.*}
pattern=${pattern//\?/.}
cat - | grep $clr "$pattern"

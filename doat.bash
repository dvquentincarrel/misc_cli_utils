if [[ $1 == '-h' ]] || [[ $# -lt 2 ]]; then
    echo 'usage: doat <TIME DESCRIPTION> COMMAND...'
    echo 'For time description, run:'
    echo 'info coreutils -n "Relative items in date strings"'
    exit $([[ $1 = -h ]])
fi
epoch=$(date -d "$1" +%s)
current=$(date +%s)
while [[ $current < $epoch ]]; do
    printf "\x1b[G$(date -d @$((epoch - current - 3600)) +%T)"
    sleep 1
    current=$(date +%s)
done

printf "\x1b[G$(date -d @$((epoch - current - 3600)) +%T)\n"

shift
"$@"

# move up the directory tree n times
function cd..() {
    if [ -z "${1}" ]; then
        cd ..
    else
        path=$(yes '../' | head -n "${1}" | tr -d '\n')
        cd "${path}"
    fi
}

# man but backup to --help
function ma() {
    cmd=$(echo "$@" | tr ' ' '-')
    (man "$cmd") || ("$cmd" --help | bat -l man --style=plain)
}

# move up the directory tree n times
function cd..() {
    if [ -z "${1}" ]; then
        cd ..
    else
        path=$(yes '../' | head -n "${1}" | tr -d '\n')
        cd "${path}"
    fi
}

# start ssh-agent, add provided key
function sshstart() {
    eval $(ssh-agent -s)
    ssh-add "${HOME}/.ssh/${1}"
}
function showkeys() {
    # This function returns its value by setting COMPREPLY
    # COMPREPLY must be set to the return value of a call to `compgen`
    # The `compgen -W` command takes two args: a string of space-delimited choices and the current user input
    COMPREPLY=($(compgen -W "$(ls ${HOME}/.ssh | rg '.pub' | sd '.pub' '')" "${COMP_WORDS[1]}"))
}
# complete the sshstart function by calling the showkeys function
complete -F showkeys sshstart

# man but backup to --help
function ma() {
    cmd=$(echo "$@" | tr ' ' '-')
    (man "$cmd") || ("$cmd" --help | bat -l man --style=plain)
}

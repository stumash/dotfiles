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
    COMPREPLY=($(compgen -W "$(ls ${HOME}/.ssh | rg '.pub' | sd '.pub' '')" "${COMP_WORDS[1]}"))
}
complete -F showkeys sshstart

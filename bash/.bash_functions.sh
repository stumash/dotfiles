# utilities

# move up the directory tree n times
function cd..() {
    if [ -z "${1}" ]; then
        cd ..
    else
        path=$(yes '../' | head -n "${1}" | tr -d '\n')
        cd "${path}"
    fi
}

# helpers

# python expression printer
function p() {
    python3 -c "print($*)"
}
# javascript expression printer
function j() {
    node -e "console.log($*)"
}
# start ssh-agent, add provided key
function sshstart() {
    eval $(ssh-agent -s)
    ssh-add "${1}"
}

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

# activate a python virtualenv in the current directory or nearest ancestor directory
function activate() {
    venvname="$1"

    if [ -z "$venvname" ]
    then
        venvname="venv"
    fi

    path2virtualenv="$(pwd)"
    while [ ! -d "$path2virtualenv/$venvname" ] && [ "$path2virtualenv" != "/" ]
    do
        path2virtualenv="${path2virtualenv%/*}"
    done

    if [ "$path2virtualenv" != "/" ]
    then
        source "$path2virtualenv/$venvname/bin/activate"
    else
        echo "no virtualenv named \"$venvname\" found"
    fi
}

# helpers

# python expression printer
function p() {
    python3 -c "print($*)"
}


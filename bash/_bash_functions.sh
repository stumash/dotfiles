# PS1 functions

# echo the current git branch if in git repo
function mygitbranch() {
    if git status 1> /dev/null 2>&1
    then
        gsFirstLine="$(git status | head -1)"
        echo "${gsFirstLine##* }"
    fi
}
# echo '(' if in git repo
function lbgit()
{ if git status 1> /dev/null 2>&1; then echo '('; fi }
# echo ')' if in git repo
function rbgit()
{ if git status 1> /dev/null 2>&1; then echo ')'; fi }
# echo a '+' if there are any changes staged for commit in git
function mygitstaged() {
    stagedPattern='Changes to be committed:'
    if git status 1> /dev/null 2>&1
    then
        nonemptyifstagedchanges=$(git status | grep "$stagedPattern")
        if [ "$nonemptyifstagedchanges" != "" ]
        then
            echo "+"
        fi
    fi
}
# echo a '+' if there are unstaged changes in git
function mygituntracked() {
    untrackedPattern='Untracked files:'
    notStagedPattern='Changes not staged for commit:'
    if git status 1> /dev/null 2>&1
    then
        nonemptyifunstagedchanges=$(git status | egrep "$untrackedPattern|$notStagedPattern")
        if [ "$nonemptyifunstagedchanges" != "" ]
        then
            echo "+"
        fi
    fi
}

# virtualenv name
function venvname() {
    if [ -n "${VIRTUAL_ENV}" ]
    then
        echo "${VIRTUAL_ENV##*/}"
    fi
}
# echo '(' if in using virtualenv
function lbvenv() {
    if [ -n "${VIRTUAL_ENV}" ]
    then
        echo "("
    fi
}
# echo ')' if in using virtualenv
function rbvenv() {
    if [ -n "${VIRTUAL_ENV}" ]
        then echo ")"
    fi
}   

# abbreviated pwd
function abbreviated_pwd() {
    pwd | sed -r "s#/home/.*$(whoami)(/)?#~\\1#" | sed -r "s#([^/]{4})[^/]+#\1#g"
}

# utilities

# move up the directory tree n times
function cd..() {
    path=$(yes '../' | head -n "${1}" | tr -d '\n')
    cd "${path}"
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

# Update the PS1 variable
# 
# Note that like all bash functions, the scope of variables inside the function is the CALLING SCOPE.
# In this case, this function is set as the PROMPT_COMMAND varialbe in .bash_profile, and so is called
# in EVERY SHELL AFTER EVERY COMMAND.
function update_ps1() {
    RE='\[\e[38;5;196m\]' # red
    OR='\[\e[38;5;202m\]' # orange
    YE='\[\e[38;5;11m\]'  # yellow
    GR='\[\e[01;32m\]'    # green
    BL='\[\e[01;34m\]'    # blue
    END='\[\e[00m\]'      # end color

    PS1=""
    PS1+="\n$OR|$BL$(abbreviated_pwd)$END " # abbreviated pwd
    PS1+="$(GIT_PS1)" # git
    PS1+="$GR$(venvname)" # virtualenv
    PS1+="\n$OR|$BL\u$OR@$BL\h$OR\$$END "
}


# abbreviated pwd
function abbreviated_pwd() {
    if which gsed > /dev/null 2>&1; then # basically, if MacOS, use gsed instead of sed
        pwd | gsed -r "s#/home/.*$(whoami)(/)?#~\\1#" | gsed -r 's#([^/]{4})[^/]+#\1#g'
    else
        pwd | sed  -r "s#/home/.*$(whoami)(/)?#~\\1#" | sed  -r 's#([^/]{4})[^/]+#\1#g'
    fi
}


# assemble the git portion of the PS1
function GIT_PS1() {
    _GIT_STATUS=""
    _GIT_BRANCH=""
    _GIT_STAGED=""
    _GIT_UNTRACKED=""
    GIT_BRANCH # set _GIT_BRANCH and _GIT_STATUS
    GIT_STAGED # set _GIT_STAGED
    GIT_UNTRACKED # set _GIT_UNTRACKED
    echo "$YE$_GIT_BRANCH$GR$_GIT_STAGED$RE$_GIT_UNTRACKED "
}
# echo the current get branch in yellow
function GIT_BRANCH() {
    if git status > /dev/null 2>&1; then
        _GIT_STATUS="$(git status)"
    fi
    _GIT_STATUS_FIRST_LINE="$(echo "${_GIT_STATUS}" | head -1)"
    _GIT_BRANCH="${_GIT_STATUS_FIRST_LINE##* }"
}
# echo a green '+' if there are any changes staged for commit in git
function GIT_STAGED() {
    stagedPattern='Changes to be committed:'
    nonemptyifstagedchanges="$(echo "${_GIT_STATUS}" | grep "$stagedPattern")"
    if [ "${nonemptyifstagedchanges}" != "" ]; then
        _GIT_STAGED="+"
    fi
}
# echo a red '+' if there are unstaged changes in git
function GIT_UNTRACKED() {
    untrackedPattern='Untracked files:'
    notStagedPattern='Changes not staged for commit:'
    nonemptyifunstagedchanges=$(echo "${_GIT_STATUS}" | egrep "$untrackedPattern|$notStagedPattern")
    if [ "$nonemptyifunstagedchanges" != "" ]; then
        _GIT_UNTRACKED="+"
    fi
}


# virtualenv name
function venvname() {
    if [ -n "${VIRTUAL_ENV}" ]; then
        echo "(${VIRTUAL_ENV##*/})"
    fi
}


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


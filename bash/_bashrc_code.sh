# imports
[ -f ~/.bash_aliases.sh ]   && source ~/.bash_aliases.sh
[ -f ~/.bash_functions.sh ] && source ~/.bash_functions.sh
[ -f ~/.bash_env.sh ]       && source ~/.bash_env.sh

# bash with vim keys
set -o vi
bind -m vi 'L':'clear-screen'

# PS1
if [[ ! "${TERM}" =~ (xterm-color)|(.*256color) ]]; then
    echo "error: ~/.bashrc: not color terminal"
    exit 1
fi
shopt -u promptvars
PROMPT_COMMAND=update_ps1 # update_ps1 is from bash_functions.sh

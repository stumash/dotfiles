# imports
[ -f ~/.bash_aliases.sh ]   && source ~/.bash_aliases.sh
[ -f ~/.bash_functions.sh ] && source ~/.bash_functions.sh
[ -f ~/.bash_env.sh ]       && source ~/.bash_env.sh

# bash with vim keys
set -o vi
bind -m vi 'L':'clear-screen'

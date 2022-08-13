# imports
[ -f "$HOME/.bash_aliases.sh" ]   && source "$HOME/.bash_aliases.sh"
[ -f "$HOME/.bash_functions.sh" ] && source "$HOME/.bash_functions.sh"
[ -f "$HOME/.bash_env.sh" ]       && source "$HOME/.bash_env.sh"

export PATH="$HOME/bin/:$PATH"

# bash with vim keys
set -o vi
bind -m vi 'L':'clear-screen'

# path
export PATH="$HOME/bin/:$PATH"

# bash with vim keys
set -o vi
bind -m vi 'L':'clear-screen'

# initialize some tools
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
which starship > /dev/null 2>&1 && eval "$(starship init bash)"
which pyenv > /dev/null 2>&1 && eval "$(pyenv init -)"
which zoxide > /dev/null 2>&1 && eval "$(zoxide init bash)"
which bat > /dev/null 2>&1 && export PAGER='bat'
which bat > /dev/null 2>&1 && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# imports
[ -f "$HOME/.bash_aliases.sh" ]   && source "$HOME/.bash_aliases.sh"
[ -f "$HOME/.bash_functions.sh" ] && source "$HOME/.bash_functions.sh"
[ -f "$HOME/.bash_env.sh" ]       && source "$HOME/.bash_env.sh"

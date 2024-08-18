# path
export PATH="$HOME/bin/:$PATH"

# bash with vim keys
set -o vi

# asdf first, then its tools, then everything else
[ -f "$HOME/.asdf/asdf.sh" ] &&    source "$HOME/.asdf/asdf.sh"
which asdf > /dev/null 2>&1 &&     source "$HOME/.asdf/installs/rust/stable/env"

# initialize some tools
[ -f "$HOME/.cargo/env" ] &&  	   source "$HOME/.cargo/env"
which starship > /dev/null 2>&1 && eval "$(starship init zsh)"
which zoxide > /dev/null 2>&1 &&   eval "$(zoxide init zsh)"
which bat > /dev/null 2>&1 &&      export PAGER='bat'
which bat > /dev/null 2>&1 &&      export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# imports
[ -f "$HOME/.zsh_aliases.zsh" ]   && source "$HOME/.zsh_aliases.zsh"
[ -f "$HOME/.zsh_functions.zsh" ] && source "$HOME/.zsh_functions.zsh"
[ -f "$HOME/.zsh_env.zsh" ]       && source "$HOME/.zsh_env.zsh"

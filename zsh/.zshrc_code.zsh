ZVM_INIT_MODE=sourcing
# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-vi-mode ssh gradle asdf fzf ssh-agent)
source $ZSH/oh-my-zsh.sh

# path
export PATH="$HOME/bin/:$PATH"

# asdf first, then its tools, then everything else
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# initialize some tools
[ -f "$HOME/.cargo/env" ] &&     source "$HOME/.cargo/env"
which zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh)"
which fzf > /dev/null 2>&1 &&    source <(fzf --zsh)
which bat > /dev/null 2>&1 &&    export PAGER='bat'
which bat > /dev/null 2>&1 &&    export MANPAGER="sh -c 'col -bx | bat -l man -p'"

which starship > /dev/null 2>&1 && [ "$STARSHIP_SHELL" != "zsh" ] && eval "$(starship init zsh)"

# imports
[ -f "$HOME/.zsh_aliases.zsh" ]   && source "$HOME/.zsh_aliases.zsh"
[ -f "$HOME/.zsh_functions.zsh" ] && source "$HOME/.zsh_functions.zsh"
[ -f "$HOME/.zsh_env.zsh" ]       && source "$HOME/.zsh_env.zsh"
[ -f "$HOME/.zsh_ssh.zsh" ]       && source "$HOME/.zsh_ssh.zsh"

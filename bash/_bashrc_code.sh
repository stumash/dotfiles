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
RE='\[\033[38;5;196m\]' # red
OR='\[\033[38;5;202m\]' # orange
YE='\[\033[38;5;11m\]'  # yellow
GR='\[\033[01;32m\]'    # green
BL='\[\033[01;34m\]'    # blue
END='\[\033[00m\]'      # end color

PS1=""
PS1+="\n$OR|$BL[\$(abbreviated_pwd)]" # abbreviated pwd
PS1+="$YE\$(lbgit)\$(mygitbranch)$GR\$(mygitstaged)$RE\$(mygituntracked)$YE\$(rbgit)" # git
PS1+="$GR\$(lbvenv)\$(venvname)\$(rbvenv)" # virtualenv
PS1+="\n$OR|$BL\u$OR@$BL\h$OR\$$END "
PS1="${debian_chroot:+($debian_chroot))}$PS1"

# the contents of this file are meant to be added to the default
# .bashrc file, not replace it

# Function definitions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.bash_environment_variables ]; then
    . ~/.bash_environment_variables
fi

# set bash to use vim keybindings
set -o vi

# put this above the 'if $color_prompt' block
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# my special prompt, put inside 'if $color_prompt'
RE='\[\033[38;5;196m\]' # red
OR='\[\033[38;5;202m\]' # orange
YE='\[\033[38;5;11m\]' # yellow
GR='\[\033[01;32m\]' # green
BL='\[\033[01;34m\]' # blue
END='\[\033[00m\]' # end color

PS1="\n$OR|$BL[\$(abbreviated_pwd)]" # abbreviated pwd
PS1="$PS1$YE\$(lbgit)\$(mygitbranch)$GR\$(mygitstaged)$RE\$(mygituntracked)$YE\$(rbgit)" # git
PS1="$PS1$GR\$(lbvenv)\$(venvname)\$(rbvenv)" # virtualenv
PS1="$PS1\n$OR|$BL\u$OR@$BL\h$OR\$$END "
PS1="${debian_chroot:+($debian_chroot)}$PS1"

# put this after the 'if $color_prompt' block
unset color_prompt force_color_prompt

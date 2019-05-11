# always use vim!
EDITOR=nvim
VISUAL=$EDITOR 
export EDITOR VISUAL
COLORTERM=gnome-terminal #nvim is still under development, so
export COLORTERM # setting + exporting COLORTERM is needed for now

# virtualenv shouldn't be messing with my PS1 variable (shell prompt)
VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUAL_ENV_DISABLE_PROMPT

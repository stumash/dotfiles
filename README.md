# dotfiles

### bash

installs the following as hardlinks:

* `~/.bash_functions.sh`
* `~/.bash_aliases.sh`
* `~/.bashrc_code.sh`
* `~/.bashrc_env.sh`

this will also set up the `${PS1}` variable to be fancy

### git

adds aliases and other to `~/.gitconfig` if they are not present

### vim

installs the following as hardlinks:

* `~/.vimrc`
* `${nvimconfigdir}/.init.vim`
* `${bundir}/vim-packages`

also installs pathogen and then clones some vim plugins to the right folder

### other

installs the following as hardlinks:

* `~/.haskeline`
* `~/.latexmkrc`
* `~/.tmux.conf`

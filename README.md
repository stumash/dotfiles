# dotfiles

### Tools I Use

* rust
  * rustup
  * exa
  * fd
  * sd
  * rg
  * choose
  * procs
  * bat
  * starship
  * delta
* gogh
* neovim
  * vim-plug
* tmux

### bash

installs the following as hardlinks:

* `~/.bash_functions.sh`
* `~/.bash_aliases.sh`
* `~/.bashrc_code.sh`
* `~/.bashrc_env.sh`

this will also set up the `${PS1}` variable to be fancy

### git

adds aliases and other to `~/.gitconfig` if they are not present

### neovim

Installs the following as hardlinks:

* `${nvimconfigdir}/init.vim` (`$nvimconfigdir` is usually `~/.config/nvim/`)

### other

installs the following as hardlinks:

* `~/.haskeline`
* `~/.latexmkrc`
* `~/.tmux.conf`

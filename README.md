# dotfiles

This project really only works if you clone it to your `~` (`$HOME`) folder.

`./install.sh` to install my dotfile configurations.

### Tools I Use

* stow
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
* jq
* neovim
  * vim-plug
* tmux
  * tpm
  * tmux-pain-control
  * tmux-thumbs

### bash

installs softlinks for

* `~/.bash_functions.sh`
* `~/.bash_aliases.sh`
* `~/.bashrc_code.sh`
* `~/.bashrc_env.sh`

### git

doesn't install anything. just prints the lines you should put in your

* `~/.gitconfig`

### neovim

installs softlinks for

* `~/.config/nvim/lua/helpers.lua`
* `~/.config/nvim/init.vim`

### other

installs softlinks for

* `~/.haskeline`
* `~/.latexmkrc`
* `~/.tmux.conf`
* `~/.tmuxline.conf`

### starship

installs softlinks for

* `~/.config/starship.toml`

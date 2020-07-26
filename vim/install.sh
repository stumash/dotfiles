#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

# INSTALL NEOVIM IF NECESSARY

if [ -z "$(which nvim)" ]; then
    echo "warning: dotfiles/vim/install.sh: need to install neovim"
    echo "installing neovim..."

    # install neovim dependencies, then add neovim repository info,
    # then update index, then install neovim and neovim python3 package

    sudo apt-get install software-properties-common && \
    sudo apt-get install python-software-properties && \
    sudo add-apt-repository ppa:neovim-ppa/stable && \
    sudo apt-get update && \
    sudo apt-get install neovim && \
    python3 -m pip install neovim
fi

# INSTALL NEOVIM CONFIG

[ -f "${HOME}/.vimrc" ] && rm "${HOME}/.vimrc"
ln -f "$(readlink -f "_vimrc")" "${HOME}/.vimrc"

nvimconfdir="${HOME}/.config/nvim"
nvimconffile="init.vim"
[ -f "$nvimconfdir}/$nvimconffile}" ] && rm "$nvimconfdir/$nvimconffile"
mkdir -p "$nvimconfdir" && \
ln -f "$(readlink -f "_init.vim")" "$nvimconfdir/$nvimconffile"

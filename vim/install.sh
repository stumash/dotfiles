#!/usr/bin/env bash

if [[ "${OSTYPE}" == "darwin"* ]]; then
    function fullname() { greadlink "${@}"; }
else
    function fullname() { readlink "${@}"; }
fi
THIS_DIR="$(dirname "$(fullname -f "${BASH_SOURCE[0]}")")"

nvim_confdir="$HOME/.config/nvim"
mkdir -p $nvim_confdir
ln $THIS_DIR $nvim_confdir

# INSTALL NEOVIM IF NECESSARY
which nvim || echo "YOU NEED TO INSALL NEOVIM"
test -e $nvim_confdir/plugged || echo "YOU NEED TO INSTALL VIM-PLUG"

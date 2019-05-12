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
ln "$(readlink -f "_vimrc")" "${HOME}/.vimrc"

# setup dirs for pathogen and install pathogen
[ -d "${HOME}/.vim" ] && rm -rf "${HOME}/.vim"
bundir="${HOME}/.vim/bundle"
autodir="${HOME}/.vim/autoload"
mkdir -p "$autodir" "$bundir" && \
curl -LSso "$autodir/pathogen.vim" "https://tpo.pe/pathogen.vim"

nvimconfdir="${HOME}/.config/nvim"
[ -f "${nvimconfdir}/.init.vim" ] && rm "${nvimconfdir}/.init.vim"
mkdir -p "$nvimconfdir" && \
ln "$(readlink -f "_init.vim")" "$nvimconfdir/.init.vim"

# install vim packages
[ -f "${bundir}/vim-packages" ] && rm "${bundir}/vim-packages"
ln "$(readlink -f  "_vim-packages")" "$bundir/vim-packages"
while read line; do
  if [ "${line:0:1}" != "#" ]; then # ignore commented lines
    git clone "$line" "$bundir/${line##*/}"
  fi
done < "$bundir/vim-packages"

# install my-ulti-snippets
mkdir -p "$bundir/my-ulti-snippets"
for FILE in $(ls "_my_ulti_snippets"); do
    [ -f "${bundir}/my-ulti-snippets/${FILE}" ] && rm "${bundir}/my-ulti-snippets/${FILE}"
    ln "$(readlink -f "_my_ulti_snippets/$FILE")" "$bundir/my-ulti-snippets/$FILE"
done

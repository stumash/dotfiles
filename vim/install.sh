#!/usr/bin/env bash

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

ln -s "_vimrc" "~/.vimrc"

# setup dirs for pathogen and install pathogen
bundir="~/.vim/bundle"
autodir="~/.vim/autoload"
mkdir -p "$autodir" "$bundir" && \
curl -LSso "$autodir/pathogen.vim" "https://tpo.pe/pathogen.vim"

nvimconfdir="~/.config/nvim"
mkdir -p "$nvimconfdir" && \
ln -s "_init.vim" "$nvimconfdir/.init.vim"

# install vim packages
ln -s "_vim-packages" "$bundir/vim-packages"
while read line; do
  if [ "${line:0:1}" != "#" ]; then # ignore commented lines
    git clone "$line" "$bundir/${line##*/}"
  fi
done < "$bundir/vim-packages"

# install my-ulti-snippets
mkdir -p "$bundir/my-ulti-snippets"
for FILE in "$(ls -1 "_my_ulti_snippets")"; do
    ln -s "_my_ulti_snippets/$FILE" "$bundir/my-ulti-snippets/$FILE"
done

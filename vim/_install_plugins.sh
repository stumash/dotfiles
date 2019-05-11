#!/usr/bin/env bash

cp ".vimrc" "$HOME"

# setup dirs for pathogen and install pathogen
bundir="$HOME/.vim/bundle"
autodir="$HOME/.vim/autoload"
mkdir -p "$autodir" "$bundir" && \
curl -LSso "$autodir/pathogen.vim" "https://tpo.pe/pathogen.vim"


nvimconfdir="$HOME/.config/nvim"
mkdir -p "$nvimconfdir" && \
cp ".init.vim" "$nvimconfdir"

# install vim packages
cp "vim-packages" "$bundir"
while read line; do
  if [ "${line:0:1}" != "#" ]; then # ignore commented lines
    git clone "$line" "$bundir/${line##*/}"
  fi
done < "$bundir/vim-packages"

# install private UltiSnips snippets
git clone "https://gist.github.com/stumash/af6dd099c6eacd08d5f430930b425ff4" "$bundir/my-ulti-snippets"

# can swap your capslock and escape if Ubuntu
# sudo vim /etc/default/keyboard and edit
# to `KBOPTIONS="caps:swapescape"` then run
# sudo dpkg-reconfigure -phigh console-setup
# or just use gnome-tweak-tool

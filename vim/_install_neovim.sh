#!/usr/bin/env bash

# install neovim dependencies, then add neovim repository info,
# then update index, then install neovim and neovim python3 package

sudo apt-get install software-properties-common && \
sudo apt-get install python-software-properties && \
sudo add-apt-repository ppa:neovim-ppa/stable && \
sudo apt-get update && \
sudo apt-get install neovim && \
pip3 install neovim

#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

function install_fish() {
    sudo apt-get install fish
}

function install_oh_my_fish() {
    curl -L https://get.oh-my.fish | fish
}

function install_oh_my_fish_theme_bobthefish() {
    omf install bobthefish
}

install_fish && \
    install_oh_my_fish && \
    install_oh_my_fish_theme_bobthefish

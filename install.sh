#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"


for DOTFILE_INSTALL_SCRIPT in "bash" "git" "vim" "other"; do
    ./"${DOTFILE_INSTALL_SCRIPT}"/install.sh
done

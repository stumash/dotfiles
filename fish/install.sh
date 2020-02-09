#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

which fish || sudo apt-get install fish

"${THIS_DIR}/install.fish" "${@}"

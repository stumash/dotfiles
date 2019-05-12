#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

[ -f "${HOME}/.gitconfig" ] && rm "${HOME}/.gitconfig"
ln "$(readlink -f "_gitconfig")" "${HOME}/.gitconfig"

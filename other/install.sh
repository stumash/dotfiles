#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

FILEMAP=(
    ["_haskeline"] "~/.haskeline"
    ["_latexmkrc"] "~/.latexmkrc"
    ["_tmux.conf"] "~/.tmux.conf"
)

for TARGET in "${!FILEMAP[@]}"; do
    LINK="${FILEMAP[${TARGET}]}"

    ln -s "${TARGET}" "${LINK}"
done

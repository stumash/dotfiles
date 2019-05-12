#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

FILEMAP=(
    ["_haskeline"]="${HOME}/.haskeline"
    ["_latexmkrc"]="${HOME}/.latexmkrc"
    ["_tmux.conf"]="${HOME}/.tmux.conf"
)

for TARGET in "${!FILEMAP[@]}"; do
    LINK="${FILEMAP[${TARGET}]}"
    TARGET="$(readlink -f "${TARGET}")"

    echo "LINK: ${LINK} , TARGET: ${TARGET}"

    [ -f "${TARGET}" ] && rm "${TARGET}"
    ln "${TARGET}" "${LINK}"
done

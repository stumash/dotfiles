#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

declare -A FILEMAP
FILEMAP=(
    ["_haskeline"]="${HOME}/.haskeline"
    ["_latexmkrc"]="${HOME}/.latexmkrc"
    ["_tmux.conf"]="${HOME}/.tmux.conf"
)

for TARGET in "${!FILEMAP[@]}"; do
    LINK="${FILEMAP[${TARGET}]}"
    TARGET="$(readlink -f "${TARGET}")"

    echo "link: ${LINK}, target: ${TARGET}"

    [ -f "${LINK}" ] && rm "${LINK}"
    ln "${TARGET}" "${LINK}"
done

cat <<EOF
# more things to install:
# tmux
# rustup
# ripgrep
# fzf
# ranger (ranger-fm)
# YCM setup (libclang, go)
EOF

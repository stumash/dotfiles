#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

declare -A FILEMAP=(
    ["_bash_aliases.sh"]="${HOME}/.bash_aliases.sh"
    ["_bash_env.sh"]="${HOME}/.bash_env.sh"
    ["_bash_functions.sh"]="${HOME}/.bash_functions.sh"
    ["_bashrc_code.sh"]="${HOME}/.bashrc_code.sh"
)

for TARGET in "${!FILEMAP[@]}"; do
    LINK="${FILEMAP[${TARGET}]}"
    TARGET="$(readlink -f "${TARGET}")"

    ln -f "${TARGET}" "${LINK}"
done

# BASHRC INCLUDE

FN='.bashrc_code.sh'
if [ -z "$(sed -n "/[ -f ~\\/${FN} ] && source ~\\/${FN}/p" "${HOME}/.bashrc")" ]; then
    echo "[ -f ~/${FN} ] && source ~/${FN}" >> "${HOME}/.bashrc"
fi

# GIT TAB COMPLETION INCLUDE

NEW_GIT_COMPLETION_FILE="${HOME}/.bash_git_completions.sh"
DEFAULT_GIT_COMPLETION_FILE=
POSSIBLE_DEFAULT_GIT_COMPLETION_FILES=(
    "/usr/share/bash-completion/completions/git"
)

for FILE in "${POSSIBLE_DEFAULT_GIT_COMPLETION_FILES[@]}"; do
    if [ -f "${FILE}" ]; then
        DEFAULT_GIT_COMPLETION_FILE="${FILE}"
        break
    fi
done
if [ -z "${DEFAULT_GIT_COMPLETION_FILE}" ]; then
    echo "error: dotfiles/git/install.sh: could not find a default git completion file"
    exit 1
fi

cp "${DEFAULT_GIT_COMPLETION_FILE}" "${NEW_GIT_COMPLETION_FILE}"

FN=".bash_git_completions.sh"
if [ -z "$(sed -n "/[ -f ~\\/${FN} ] && source ~\\/${FN}/p" "${HOME}/.bashrc")" ]; then
    echo "[ -f ~/${FN} ] && source ~/${FN}" >> "${HOME}/.bashrc"
fi

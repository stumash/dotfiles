#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
cd "${THIS_DIR}"

[[ ! -f "${HOME}/.gitconfig" ]] && cp "$(readlink -f "_gitconfig")" "${HOME}/.gitconfig"

FOUND_GIT_ALIASES=
FOUND_GIT_PUSH=
FOUND_GIT_DIFF=
while read LINE; do
    [[ "${LINE}" == "[alias]" ]] && FOUND_GIT_ALIASES="true"
    [[ "${LINE}" == "[push]" ]]  && FOUND_GIT_PUSH="true"
    [[ "${LINE}" == "[diff]" ]]  && FOUND_GIT_DIFF="true"
done < "${HOME}/.gitconfig"
if [[ -z "${FOUND_GIT_ALIASES}" && -z "${FOUND_GIT_PUSH}" && -z "${FOUND_GIT_DIFF}" ]]; then
    cat "$(readlink -f "_gitconfig")" >> "${HOME}/.gitconfig"
fi

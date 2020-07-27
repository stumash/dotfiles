#!/usr/bin/env bash

if [[ "${OSTYPE}" == "darwin"* ]]; then
    THIS_DIR="$(dirname "$(greadlink -f "${BASH_SOURCE[0]}")")"
else
    THIS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
fi

MY_GITCONFIG="${THIS_DIR}/_gitconfig"
LOCAL_GITCONFIG="${HOME}/.gitconfig"
[[ -f "${LOCAL_GITCONFIG}" ]] || touch ${LOCAL_GITCONFIG}

INCLUDED_MY_GITCONFIG=
while read LINE; do
    [[ "${LINE}" == "[include]" ]] && INCLUDED_MY_GITCONFIG="true"
done < "${HOME}/.gitconfig"

# gitconfig `include` requires git >1.7
if [[ -z "${INCLUDED_MY_GITCONFIG}" ]]; then
    echo -e "[include]\n    path = ${MY_GITCONFIG}" >> "${HOME}/.gitconfig"
fi

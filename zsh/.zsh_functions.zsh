# move up the directory tree n times
function cd..() {
  if [ -z "${1}" ]; then
    cd ..
  else
    path=$(yes '../' | head -n "${1}" | tr -d '\n')
    cd "${path}"
  fi
}

# man but backup to --help
function ma() {
  cmd=$(echo "$@" | tr ' ' '-')
  (man "$cmd" 2>/dev/null) || ("$cmd" --help | bat -l man --style=plain)
}

function retry() {
  local max_attempts=$1
  local cmd="${@:2}"
  local attempt=1
  until $cmd; do
    if [ $attempt -ge $max_attempts ]; then
      echo "Command failed after $max_attempts attempts."
      return 1
    fi
    echo "Attempt $attempt failed. Retrying..."
    attempt=$(( attempt + 1 ))
  done
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# shortcut to output date in a few common formats
function dt() {
  if [[ "${1}" = "u" ]]; then
    date +%s
  elif [[ "${1}" = "i" ]]; then
    date -Iseconds
  elif [[ "${1}" = "r" ]]; then
    date -R
  elif [[ "${1}" = "a" ]]; then
    date +'%m/%d/%Y %H:%M:%S'
  elif [[ "${1}" = "s" ]]; then
    date +'%d/%m/%Y %H:%M:%S'
  elif [[ "${1}" == "h" || "${1}" == "-h" || "${1}" == "--help" ]]; then
    cat << EOF

NAME
    dt - format the current date and time

SYNOPSIS
    dt [format|options]

DESCRIPTION
    The dt utility formats and prints the current date and time in
    various predefined formats. If an argument is not one of the
    recognized formats, it is passed directly as an option to the
    system's date(1) command.

OPTIONS
    The following single-letter format arguments are supported:

    u   Unix timestamp (e.g., seconds since 1970-01-01 00:00:00 UTC).

    i   ISO 8601 format (e.g., YYYY-MM-DDTHH:MM:SS+00:00).

    r   RFC 2822 format (e.g., Day, DD Mon YYYY HH:MM:SS +0000).

    a   American format (e.g., MM/DD/YYYY HH:MM:SS).

    s   Standard format (e.g., DD/MM/YYYY HH:MM:SS).

    h   Displays this help message and exits.

    Any other options are passed through to the date(1) command. For
    example, dt "+%Y-%m-%d" would work as expected.

EXAMPLES
    1. Display the current Unix timestamp:
       $ dt u

    2. Display the date in ISO 8601 format:
       $ dt i

SEE ALSO
    date(1)
EOF
  else
    date ${@}
  fi
}


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
    (man "$cmd") || ("$cmd" --help | bat -l man --style=plain)
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

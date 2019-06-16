#!/bin/bash

pushd "${BASH_IT}" >/dev/null || exit 1

if [ ! -z "${1}" ] && [[ "${1}" =~ ^(aliases|completion|plugins)$ ]]; then
  for _bash_it_config_file in $(sort <(compgen -G "./${1}/*.bash")); do
    if [ -e "$_bash_it_config_file" ]; then
      # shellcheck source=/dev/null
      source "$_bash_it_config_file"
    else
      echo "Unable to locate ${_bash_it_config_file}" > /dev/stderr
    fi
  done
fi

unset _bash_it_config_file
unset _bash_it_config_type
popd >/dev/null || exit 1

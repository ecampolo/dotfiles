#!/bin/bash
pushd "${BASH_IT}" >/dev/null || exit 1

for _bash_it_file in $(sort <(compgen -G "./${1}/*.bash")); do
    if [ -e "$_bash_it_file" ]; then
        source "$_bash_it_file"
    else
        echo "unable to locate ${_bash_it_file}" > /dev/stderr
    fi
done

unset _bash_it_file
popd >/dev/null || exit 1

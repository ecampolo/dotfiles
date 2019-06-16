#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE}")";

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "sync.sh" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
        --exclude "bash-it-sync/" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

printf "%s\n" "running bash-it-sync job"
./bash-it-sync-bin
printf "%s\n" "executing rsync"
doIt;
unset doIt;

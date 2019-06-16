#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE}")";

echo "Pulling last version from github"
git pull origin master;

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

doIt;
unset doIt;

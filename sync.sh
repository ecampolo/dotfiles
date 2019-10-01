#!/usr/bin/env bash
set -e

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "sync.sh" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
        --exclude "bash-it-sync/" \
        --exclude "bash-it-sync-bin" \
		-avh --no-perms . ~;
}

doIt;
unset doIt;

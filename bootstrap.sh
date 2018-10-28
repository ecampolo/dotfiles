#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE}")";

echo "Pulling last version from github"
git pull origin master;
echo "Downloading last sexy bash prompt"
curl -sO https://raw.githubusercontent.com/twolfson/sexy-bash-prompt/master/.bash_prompt

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

doIt;
unset doIt;

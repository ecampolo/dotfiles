#!/usr/bin/env bash

# Install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
brew install coreutils

# Install Bash 5.
brew install bash
brew install bash-completion@2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Set up GNU core utilities (those that come with OS X are outdated).
echo 'Be sure to add `$(brew prefix coreutils|findutils|gnu-sed)/libexec/gnubin` to `$PATH`.'

brew install vim
brew install git
brew install go
brew install tree
brew cask install iterm2
brew cask install spotify

brew upgrade

# Remove outdated versions from the cellar.
brew cleanup

printf "Installing sdkman\n"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

printf "Downloading sexy bash prompt\n"
curl -s -o ~/.bash_prompt https://raw.githubusercontent.com/twolfson/sexy-bash-prompt/master/.bash_prompt

printf "Installing Vimplug\n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

printf "Copying ssh files"
cp -rp ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/meli/.ssh/ ~/.ssh/

printf "Finished\n"

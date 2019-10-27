#!/usr/bin/env bash

# Install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
brew install coreutils ed findutils gawk gnu-sed gnu-tar grep make

# Install Bash 5.
brew install bash
brew install bash-completion@2

# Switch to using brew-installed bash as default shell
if ! grep -Fq "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

brew install vim
brew install git
brew install go
brew install jump
brew install wget
brew install jq
brew install openssl
brew install htop
brew install tree
brew install watch

brew cask install iterm2
brew cask install spotify
brew cask install google-chrome

printf "Installing sdkman\n"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

printf "Downloading sexy bash prompt\n"
curl -s -o ~/.bash_prompt https://raw.githubusercontent.com/twolfson/sexy-bash-prompt/master/.bash_prompt

printf "Installing Vimplug\n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

printf "Finished\n"

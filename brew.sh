#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Install Homebrew if not installed.
if ! brew info cask &>/dev/null; then
	echo "Homebrew Will be install before Installing Other Packages"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew Already Installed, Installing other Packages"
fi

# Turn Off Homebrew Analytics
brew analytics off

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

#Tap into Additional repository
brew tap Homebrew/bundle
brew tap "homebrew/versions"
brew tap "caskroom/cask"
brew tap "caskroom/fonts"
brew tap "caskroom/versions"
brew tap "homebrew/dupes"
brew tap "homebrew/nginx"
brew tap "homebrew/fuse"
brew tap "homebrew/x11"
brew tap "homebrew/apache"
brew tap "homebrew/completions"
brew tap "homebrew/php"

# Install Brew formulae and apps via Cask
brew bundle -v

# Remove outdated versions from the cellar.
brew cleanup


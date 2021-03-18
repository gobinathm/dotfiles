#! /bin/bash

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

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install collection of binary tools
brew install binutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install wget with IRI support
brew install wget

#Tap into Additional repository
brew tap Homebrew/bundle
brew tap homebrew/command-not-found

# Install Brew formulae and apps via Cask
# this will process the Brewfile in the current directory
brew bundle -v

# Remove outdated versions from the cellar.
brew cleanup

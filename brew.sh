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

# Install Mac Application Store Softwares.

# CheatSheet
mas install 529456740
# DrCleanerPreview
mas install 1092417256
# iwork ~ Keynote
mas install 409183694
# Amazon Kindle Kindle
mas install 405399194
# Last Pass LastPass
mas install 926036361
# Microsoft OneNote 
mas install 784801555
# VOX Music Player
mas install 461369673
# Sofortbild
mas install 411729406
# Clean ~ The Desktop Cleaner
mas install 418412301
# Pixelmator
mas install 407963104
# Aperture
mas install 408981426
# Duplicates Cleaner 
mas install 1012324495
# Xcode
mas install 497799835
# Affinity Photo 
mas install 824183456
# Wunderlist
mas install 410628904
# WhatsApp
mas install 1147396723
# iwork ~ Pages
mas install 409201541
# TextWrangler
mas install 404010395
# iwork ~ Numbers
mas install 409203825
# feedly
mas install 865500966
# iMovie
mas install 408981434
# Pocket ~ Offline Reader
mas install 568494494
#  Disk Diag 
mas install 672206759
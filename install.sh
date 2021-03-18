#! /bin/bash

# ======== XCode ==========
# Install Command Line Tools
xcode-select --install

# Agree to the XCode license
sudo xcodebuild -license

# ========= Brew ==========
./brew.sh

# ========= Basic Configurations ==========
./config.sh

# Find any problems with brew setup
brew doctor

# Remove outdated versions from the cellar.
brew cleanup

# ========= Copy basic .dotfiles ==========
source bootstrap.sh
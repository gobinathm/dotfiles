#!/usr/bin/env bash

# ======== XCode ==========

# Install Command Line Tools
xcode-select --install

# Agree to the XCode license
sudo xcodebuild -license

# ========= Brew ==========

./brew.sh

# ========= Copy basic .dotfiles ==========

./bootstrap.sh
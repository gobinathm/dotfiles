#!/usr/bin/env bash


# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
read -s -p "Enter Password for sudo: " sudoPW

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Shell Setup                                                                 #
###############################################################################
# Multiple Shell Option below. Pick the one required (comment / uncomment).

# ========= Bash Shell Switch (as default)==========
echo 'Switch to using brew-installed bash as default shell'
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
	# Switch to using brew-installed bash as default shell
	echo $sudoPW | sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
	# Change the bash shell for the user
	echo $sudoPW | sudo -S chsh -s /usr/local/bin/bash
fi;

# ========= Fish Shell Switch ==========
# echo 'Switch to using brew-installed fish as default shell'
# if ! fgrep -q '/usr/local/bin/fish' /etc/shells; then
#	# Switch to using brew-installed fish as default shell
#	echo $sudoPW | sudo bash -c "echo /usr/local/bin/fish >> /private/etc/shells"
#	# Change the bash shell for the user
#	echo $sudoPW | sudo -S chsh -s /usr/local/bin/fish
#fi;

# ========= zsh-completions Shell Switch ==========
# echo 'Switch to using brew-installed Zsh as default shell'
# if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
#	# Switch to using brew-installed fish as default shell
#	echo $sudoPW | sudo bash -c "echo /usr/local/bin/zsh >> /private/etc/shells"
#	# Change the bash shell for the user
#	echo $sudoPW | sudo -S chsh -s /usr/local/bin/zsh
#fi;

## Update Plugin & Switch to Zsh Shell
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# ========= Finder ==========
#
# Defaults to Icon View, for other view change icnv to one of the below
#
# Nlsv – List View
# icnv – Icon View
# clmv – Column View
# Flwv – Cover Flow View

defaults write com.apple.Finder FXPreferredViewStyle icnv

# ========= Screenshot ==========
#
# Support formats png jpg pdf gif tiff
#
# Change to the One you Link, here it defaults to PNG
defaults write com.apple.screencapture type png
# Change Default Screenshot location
defaults write com.apple.screencapture location ~/Pictures/Screenshots

# ========= Photos ==========
#
# Prevent Photos from opening automatically.
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# ========= Time Machine ==========
#
# Prevent TM from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
# Exclude Specific Files & Folders .. change the folder as required
hash tmutil &> /dev/null && sudo tmutil  addexclusion -p "~/Cloud"
# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

echo "# Update global git config"
echo $sudoPW | sudo -S git lfs install
echo "# Update system git config"
echo $sudoPW | sudo -S git lfs install --system

echo “Securing MySql”
mysql_secure_installation

echo “launchd start apache/mysql now and restart at login”
brew services start mysql
brew services start homebrew/apache/httpd24

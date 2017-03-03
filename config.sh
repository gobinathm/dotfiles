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
# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# ========= Activity Monitor ==========
#
# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

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

# ========= SSD tweaks ==========
#
# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage

# Create a zero-byte file instead…
sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
sudo chflags uchg /private/var/vm/sleepimage

# ========= Safari ==========
#
# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# ========= GIT lfs Config  ==========
#
echo "# Update global git config"
echo $sudoPW | sudo -S git lfs install
echo "# Update system git config"
echo $sudoPW | sudo -S git lfs install --system

# ========= Securing MySql  ==========
#
echo “Securing MySql”
mysql_secure_installation

# ========= Apache / MySql Service Setup   ==========
#
echo “launchd start apache/mysql now and restart at login”
brew services start mysql
brew services start homebrew/apache/httpd24
echo "Now, All Cool Stuff is Over. Some stubborn applications might like a restart (or) logout to accept the changes."

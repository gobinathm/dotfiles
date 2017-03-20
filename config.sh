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

# ========= UX & UI ==========
#
# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Appearance
defaults write -g 'AppleAquaColorVariant' -int 6

# Turn On dark menu bar and Dock
defaults write -g 'AppleInterfaceStyle' -string 'Dark'

# #CC99CC will be used for Highlight
defaults write -g 'AppleHighlightColor' -string '0.600000 0.800000 0.600000'

# Sidebar icon in small size
defaults write -g 'NSTableViewDefaultSizeMode' -int 1

# Always show the scrollbars
defaults write -g 'AppleShowScrollBars' -string 'Always'
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Jump to the next page when clicked on scroll bar
defaults write -g 'AppleScrollerPagingBehavior' -bool false

# Offer to save documents while closing
defaults write -g 'NSCloseAlwaysConfirmsChanges' -bool true

# Close windows when quitting an app: on
defaults write -g 'NSQuitAlwaysKeepsWindows' -bool false

# Use LCD font smoothing when available: on
defaults -currentHost delete -g 'AppleFontSmoothing' 2> /dev/null

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Disable Notification Center and remove the menu bar icon
#launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# ========= App Store / SW Management ==========
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

# Screen Saver: Start after: Never
defaults -currentHost write 'com.apple.screensaver' 'idleTime' -int 5

# ========= Finder ==========
#
# Defaults to Icon View, for other view change icnv to one of the below
#
# Nlsv – List View
# icnv – Icon View
# clmv – Column View
# Flwv – Cover Flow View
defaults write com.apple.Finder FXPreferredViewStyle icnv
### View

# Show Path Bar
defaults write 'com.apple.finder' 'ShowPathbar' -bool true

# Show Status Bar
defaults write 'com.apple.finder' 'ShowStatusBar' -bool true

# Customize Toolbar…
defaults write 'com.apple.finder' 'NSToolbar Configuration Browser' '{ "TB Item Identifiers" = ( "com.apple.finder.BACK", "com.apple.finder.PATH", "com.apple.finder.SWCH", "com.apple.finder.ARNG", "NSToolbarFlexibleSpaceItem", "com.apple.finder.SRCH", "com.apple.finder.ACTN" ); "TB Display Mode" = 2; }'

# allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Copy
defaults write 'com.apple.finder' 'CopyProgressWindowLocation' -string '{2160, 23}'

# Show these items on the desktop: Hard disks: on
defaults write 'com.apple.finder' 'ShowHardDrivesOnDesktop' -bool false

# Show these items on the desktop: External disks: on
defaults write 'com.apple.finder' 'ShowExternalHardDrivesOnDesktop' -bool false

# Show these items on the desktop: CDs, DVDs, and iPods: on
defaults write 'com.apple.finder' 'ShowRemovableMediaOnDesktop' -bool false

# Show these items on the desktop: Connected servers: on
defaults write 'com.apple.finder' 'ShowMountedServersOnDesktop' -bool false

# New Finder windows show: ${HOME}
defaults write 'com.apple.finder' 'NewWindowTarget' -string 'PfHm'
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show all filename extensions: on
defaults write -g 'AppleShowAllExtensions' -bool false

# Show warning before emptying the Trash: on
defaults write 'com.apple.finder' 'WarnOnEmptyTrash' -bool false

# empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Enable the MacBook Air SuperDrive on any Mac
sudo nvram boot-args="mbasd=1"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Remove Dropbox’s green checkmark icons in Finder
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Dock
#
# Icon Size: 28
defaults write com.apple.dock tilesize -int 28

# Magnification: off
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock largesize -int 64

# Position on screen: Left
defaults write com.apple.dock orientation -string left

# auto hide/show dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# minimize windows into the application icon
defaults write com.apple.dock minimize-to-application -bool true

# show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Minimize windows using: Scale effect
defaults write com.apple.dock mineffect -string scale

# Animate opening applications: off
defaults write com.apple.dock launchanim -bool false

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t group windows by app in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true


# Hot Corners : Possible values
#  0: no-op
#  2: Mission Control (all windows)
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
#
# Hot Corners… Top Left: Mission Control (all windows)
defaults write 'com.apple.dock' 'wvous-tl-corner' -int 2
defaults write 'com.apple.dock' 'wvous-tl-modifier' -int 0

# Hot Corners… Bottom Left: Desktop
defaults write 'com.apple.dock' 'wvous-bl-corner' -int 4
defaults write 'com.apple.dock' 'wvous-bl-modifier' -int 0

# Hot Corners… Top Right: Notification Center
defaults write 'com.apple.dock' 'wvous-tr-corner' -int 12
defaults write 'com.apple.dock' 'wvous-tr-modifier' -int 0

# Hot Corners… Bottom Right: Put Display to Sleep
defaults write 'com.apple.dock' 'wvous-tr-corner' -int 10
defaults write 'com.apple.dock' 'wvous-tr-modifier' -int 0

# ========= Sound ==========
#
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Play feedback when volume is changed: off
defaults write com.apple.sound.beep.feedback -bool false

# Select an alert sound: Sosumi
defaults write com.apple.systemsound com.apple.sound.beep.sound -string '/System/Library/Sounds/Sosumi.aiff'

# Play user interface sound effects: off
defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -int 0

# ========= Screen / Security ==========
#
# General: Require password: on
defaults write com.apple.screensaver askForPassword -int 1

# General: Require password: 5 seconds after sleep or screen saver begins
defaults write com.apple.screensaver askForPasswordDelay -int 5



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

# ========= Screenshot ==========
#
# Support formats png jpg pdf gif tiff
#
# Change to the One you Link, here it defaults to PNG
defaults write com.apple.screencapture type png

# Change Default Screenshot location
# Switch to Required Folders
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool false

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

# ========= Energy Saver  ==========
#
# Power Nap: enabled
sudo pmset -c powernap 1

# Auto Start after a power failure: enabled
sudo pmset -c autorestart 1

# Display off after 10 min Inactivity
sudo pmset -c displaysleep 10

# Prevent computer from sleeping when the display is off: enabled
sudo pmset -c sleep 0

# Hard disks to sleep when possible: 60 min
sudo pmset -c disksleep 60

# Wake for Ethernet network access: enabled
sudo pmset -c womp 1

# ========= Launchpad & Spotlight  ==========
#
# Add iOS & Watch Simulator to Launchpad
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

# Hide Spotlight tray-icon (and subsequent helper)
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Spotlight indexing for any volume that gets mounted
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

# ========= Terminal  ==========
#
# Install the Solarized Dark theme for iTerm
open "${HOME}/init/Solarized Dark.itermcolors"

# Don’t display prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# CharSet to use in Terminal app : UTF-8
defaults write com.apple.terminal StringEncodings -array 4

# Disable the line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

# Secure Keyboard Entry in Terminal: Enabled
# Ref: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# ========= Text to Speech  ==========
#
# Set System Voice: Allison
if [ -d '/System/Library/Speech/Voices/Allison.SpeechVoice' ]; then
	defaults write 'com.apple.speech.voice.prefs' 'VisibleIdentifiers' '{ "com.apple.speech.synthesis.voice.allison.premium" = 1; }'
	defaults write 'com.apple.speech.voice.prefs' 'SelectedVoiceName' -string 'Allison'
	defaults write 'com.apple.speech.voice.prefs' 'SelectedVoiceCreator' -int 1886745202
	defaults write 'com.apple.speech.voice.prefs' 'SelectedVoiceID' -int 184555197
fi

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

# ========= killall Applications  ==========
#
for app in "Activity Monitor" "cfprefsd" \
	"Dock" "Finder" \
	"Safari" "SystemUIServer" "Terminal"; do
	killall "${app}" &> /dev/null
done
echo "Now, All Cool Stuff is Over. Some stubborn applications might like a restart (or) logout to accept the changes."

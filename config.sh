#!/usr/bin/env bash

#! /bin/bash
read -s -p "Enter Password for sudo: " sudoPW

# Multiple Shell Option below. Pick the one required (comment / uncomment).

# ========= For Bash Users Switch Shell ==========
echo 'Switch to using brew-installed bash as default shell'
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
	# Switch to using brew-installed bash as default shell
	echo $sudoPW | sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
	# Change the bash shell for the user
	echo $sudoPW | sudo -S chsh -s /usr/local/bin/bash
fi;

# ========= For Bash Users Switch Shell ==========
# Switch to using brew-installed fish as default shell
# echo $sudoPW | sudo fish -c "echo /usr/local/bin/fish >> /private/etc/shells"
# Change the fish shell for the user
# echo $sudoPW | sudo -S chsh -s /usr/local/bin/bash

# For Zsh Users
# Update Plugin & Switch to Zsh Shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "# Update global git config"
echo $sudoPW | sudo -S git lfs install
echo "# Update system git config"
echo $sudoPW | sudo -S git lfs install --system

echo “Securing MySql”
mysql_secure_installation

echo “launchd start apache/mysql now and restart at login”
brew services start mysql
brew services start homebrew/apache/httpd24


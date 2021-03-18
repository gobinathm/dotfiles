#!/usr/bin/env bash

### :) shameless copy of https://github.com/mathiasbynens/dotfiles/blob/main/bootstrap.sh. Thanks to @mathiasbynens

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "install.sh" \
		--exclude "config.sh" \
		--exclude "brew.sh" \
		--exclude "brewfile" \
 		--exclude "README.md" \
 		--exclude "LICENSE" \
		-avh --no-perms . ~;
	source ~/.zshrc;
}

doIt;

# if [ "$1" == "--force" -o "$1" == "-f" ]; then
# 	doIt;
# else
# 	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
# 	echo "";
# 	if [[ $REPLY =~ ^[Yy]$ ]]; then
# 		doIt;
# 	fi;
# fi;
# unset doIt;
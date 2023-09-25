#!/usr/bin/env bash

echo "Setting up your mac.."

echo "Installing xcode-stuff"
xcode-select --install

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install brew apps
echo "Updating homebrew && Installing Brewfile"
brew update
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Set default MySQL root password and auth type
echo "Configuring mysql"
mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'admin'; FLUSH PRIVILEGES;"

# Configure terminal
#TODO

# Download runtimes from rtx
echo 'eval "$(/opt/homebrew/bin/rtx activate zsh)"' >> ~/.zshrc
rtx install

# Restore mackup
mackup restore

# Execute macos custom settings
chmod +x .macos
source ./.macos
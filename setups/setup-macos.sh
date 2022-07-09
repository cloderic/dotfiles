#!/usr/bin/env bash
set -o errexit

# Save screenshots to the download directory
defaults write com.apple.screencapture location -string "~/Downloads"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Install a few packages
brew install starship exa pyenv nvm

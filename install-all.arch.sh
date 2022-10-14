#!/bin/sh

# Exit on any command fail
set -e

# Variables
DIR="$( cd "$( dirname "$0" )" && pwd )"
PACMAN_INSTALL="pacman -Syu --noconfirm --needed" 

# Install everything
sudo $DIR/templates/install-common-dependencies.sh INSTALL_CMD="$PACMAN_INSTALL"
sudo $DIR/common/install-fonts.sh
sudo $DIR/common/save-tmux-zsh-histories-on-shutdown.sh
sudo $DIR/templates/install-caps-to-esc.sh INSTALL_CMD="$PACMAN_INSTALL"

# Dot files 

### Install chezmoi 
sudo $PACMAN_INSTALL chezmoi

### Setup chezmoi, pull and apply the dotfiles
chezmoi init --apply --force --ssh le-quentin

### Load the new fancy config!
source ~/.zshrc


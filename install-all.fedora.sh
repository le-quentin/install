#!/bin/sh

# Exit on any command fail
set -e

# Variables
DIR="$( cd "$( dirname "$0" )" && pwd )"
DNF_INSTALL="dnf install -y --allowerasing" 

# Fedora specific : enable some independant repositories
sudo dnf copr enable -y fszymanski/interception-tools

# Install everything
sudo $DIR/templates/install-common-dependencies.sh INSTALL_CMD="$DNF_INSTALL"
sudo $DIR/common/install-fonts.sh
sudo $DIR/common/save-tmux-zsh-histories-on-shutdown.sh
sudo $DIR/templates/install-caps-to-esc.sh INSTALL_CMD="$DNF_INSTALL"
sudo $DIR/templates/install-i3-env.sh INSTALL_CMD="$DNF_INSTALL"

# asdf, managing versions for a lot (if not all) languages
# WILL NEED A TWEAKING IN .ZSHRC. Probs should be done with chezmoi templates.
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3

# Dot files 

### Install chezmoi 
sudo $DNF_INSTALL https://github.com/twpayne/chezmoi/releases/download/v2.25.0/chezmoi-2.25.0-x86_64.rpm

### Setup chezmoi, pull and apply the dotfiles
chezmoi init --apply --force --ssh le-quentin

# Vim and terminal config
$DIR/common/setup-terminal-and-vim.sh

# Setup asdf (in a separate script runnign with zsh)
$DIR/common/setup-asdf.sh

### Change the shell and ask for relogin
chsh -s /usr/bin/zsh
echo "Your default shell has been changed, please login again."


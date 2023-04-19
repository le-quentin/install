#!/bin/sh

# Exit on any command fail
set -e

# Variables
DIR="$( cd "$( dirname "$0" )" && pwd )"
PACMAN_INSTALL="pacman -Syu --noconfirm --needed" 

# Install everything
sudo $DIR/templates/install-common-dependencies.sh INSTALL_CMD="$PACMAN_INSTALL"
sudo $DIR/templates/install-docker.sh INSTALL_CMD="$PACMAN_INSTALL"
sudo $DIR/common/install-fonts.sh
sudo $PACMAN_INSTALL noto-fonts-emoji # necessary to see proper emojis in Vivaldi
sudo $DIR/common/save-tmux-zsh-histories-on-shutdown.sh
sudo $DIR/templates/install-caps-to-esc.sh INSTALL_CMD="$PACMAN_INSTALL"
sudo $DIR/templates/install-i3-env.sh INSTALL_CMD="$PACMAN_INSTALL"

# Automatic snapshot setup with timeshift and pacman hook
sudo $PACMAN_INSTALL timeshift timeshift-autosnap grub-btrfs

# btrfmaintenance, tools for automatic btrfs maintenance, made by one of btrfs authors
sudo $PACMAN_INSTALL btrfsmaintenance
sudo /usr/share/btrfsmaintenance/btrfsmaintenance-refresh-cron.sh # Install the cron jobs for automatic maintenance

# btdu, a tool to visualise *actual* files size in btrfs filesystem; useful when you need to free up some space and you wanna identify where are the space hogs
sudo $PACMAN_INSTALL btdu

# Dot files 

### Install chezmoi 
sudo $PACMAN_INSTALL chezmoi

### Setup chezmoi, pull and apply the dotfiles
chezmoi init --apply --force --ssh le-quentin

# Vim and terminal config
$DIR/common/setup-terminal-and-vim.sh

# Install Dropbox 
yay -S dropbox

### Change the shell and ask for relogin
chsh -s /usr/bin/zsh
echo "Your default shell has been changed, please login again."


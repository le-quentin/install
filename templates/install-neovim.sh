#!/bin/sh

#Exit on any command fail
set -e

#Snippet to parse named args
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

# Dependencies
# Ripgrep: used by telescope plugin
$INSTALL_CMD ripgrep
# fd: used by telescope plugin (better files find)
$INSTALL_CMD fd

# Neovim
$INSTALL_CMD neovim

# Install vim-plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"

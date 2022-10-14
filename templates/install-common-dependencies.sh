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
# This will install common dependencies that are required in other install scripts, and are generally required dependencies in a dev environment anyway
# Depending on the installed distro and edition, some or all of those might be already installed, which is okay

echo $INSTALL_CMD
$INSTALL_CMD \
	make cmake gcc nodejs `# General dev/build deps`\
	alacritty zsh tmux gvim fzf `# Terminal`\
	systemd `#systemd: some stuff like machinectl might be missing`\
	thunar `# File manager`

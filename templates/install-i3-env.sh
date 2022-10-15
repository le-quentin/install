#!/bin/sh

# Install i3 and all tools and themes I like to use.
# This does not do configuration per se, the dot files are handled separately

# Exit on any command fail
set -e

# Snippet to parse named args
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

$INSTALL_CMD i3-gaps libxcursor \
   autorandr \
   picom \
   network-manager-applet volumeicon pavucontrol \
   xfce4-battery-plugin manjaro-settings-manager manjaro-settings-manager-notifier \
   conky conky-i3 \
   thunar

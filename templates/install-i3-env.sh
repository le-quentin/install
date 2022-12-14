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

$INSTALL_CMD i3-gaps \
   autorandr \
   picom \
   network-manager-applet volumeicon pavucontrol pulseaudio \
   xfce4-power-manager xfce4-battery-plugin \
   polkit-gnome \
   conky \
   thunar \
   rofi \
   polybar \
   redshift \
   flameshot

# Some packages are available only on arch distros ; defaulting to other (or none) for those
$INSTALL_CMD libxcursor 2>/dev/null || $INSTALL_CMD libXcursor
$INSTALL_CMD manjaro-settings-manager manjaro-settings-manager-notifier 2>/dev/null || $INSTALL_CMD xfce4-settings
$INSTALL_CMD conky-i3 2>/dev/null || true

# Rofi themes
cd ~
rm -rf ./.rofi-themes 2>/dev/null || true
git clone --depth=1 https://github.com/adi1090x/rofi.git .rofi-themes 
cd .rofi-themes
chmod +x setup.sh
./setup.sh

# Polybar themes
cd ~
rm -rf ./.polybar-themes 2>/dev/null || true
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git .polybar-themes
cd .polybar-themes
chmod +x setup.sh
./setup.sh

# I3wsr, to dynamically rename workspaces depending on their content
$INSTALL_CMD libxcb rust
cd /tmp
git clone https://github.com/roosta/i3wsr.git 
cd i3wsr
cargo build --release
cp target/release/i3wsr /usr/local/bin/i3wsr

# dependencies for polybar-spotify, to show the spotify player in spotify
pip install dbus-python
$INSTALL_CMD playerctl


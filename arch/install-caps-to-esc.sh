#!/bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"
INSTALL_CMD="pacman -S --noconfirm" $DIR/../templates/install-caps-to-esc.sh

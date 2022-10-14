#!/bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"
INSTALL_CMD="dnf -y" $DIR/../templates/install-caps-to-esc.sh

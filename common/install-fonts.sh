#!/bin/sh

#Exit on any command fail
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo "#################################Installing fonts..."
mkdir -p /usr/local/share/fonts
cp "$DIR"/fonts/*.ttf /usr/local/share/fonts/
cp "$DIR"/fonts/*.otf /usr/local/share/fonts/
fc-cache -f -v


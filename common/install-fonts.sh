#!/bin/sh

#Exit on any command fail
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo "#################################Installing fonts..."
cp "$DIR"/fonts/*.ttf /usr/share/fonts/
cp "$DIR"/fonts/*.otf /usr/share/fonts/
fc-cache -f -v


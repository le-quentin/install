#!/bin/sh

#Exit on any command fail
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo "#################################Installing fonts..."
cp "$DIR"/*.ttf /usr/share/fonts/
cp "$DIR"/*.otf /usr/share/fonts/
fc-cache -f -v


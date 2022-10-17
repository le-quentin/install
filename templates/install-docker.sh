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

# Install docker and set it up to run without sudo
$INSTALL_CMD docker
systemctl enable docker --now
usermod -aG docker $USER

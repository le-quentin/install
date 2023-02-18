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
$INSTALL_CMD docker docker-compose
systemctl enable docker --now
usermod -aG docker $USER

# Install docker buildx, for cross-platform builds, and qemu-user-static, to enable cross build for various platforms
# Then do the necessary docker setup
$INSTALL_CMD docker-buildx qemu-user-static
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes


#!/bin/sh

# Install caps2esc, and enable the demon
# This is a service that will replace capslock key with an escape key/ctrl key when you hold

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

echo "#################################Installing dependencies..."
$INSTALL_CMD cmake
$INSTALL_CMD gcc
$INSTALL_CMD interception-tools

echo "#################################Cloning..."
cd /tmp
rm -rf /tmp/caps2esc || true
git clone https://gitlab.com/interception/linux/plugins/caps2esc.git
cd caps2esc

echo "#################################Building..."
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build

echo "#################################Installing..."
cd build
make install

echo "#################################Configuring..."
(mkdir /etc/interception && mkdir /etc/interception/udevmon.d || true) 2>/dev/null
echo -e "- JOB: intercept -g \$DEVNODE | caps2esc -m 1 | uinput -d \$DEVNODE
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]" > /etc/interception/udevmon.d/caps-lock-to-escape-and-control.yml
systemctl enable udevmon.service
systemctl start udevmon.service

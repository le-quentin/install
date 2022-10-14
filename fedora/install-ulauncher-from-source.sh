#!/bin/sh

# Install ulauncher from git repository, and enable the daemon
# This is useful because v6 hasn´t been release yet (as of 2022-10-08), and 
# v5 doesn´t handle switching to an already open app...
# Using a commit hash that was tested and deemed stable.

# Will become obsolete when ulauncher releases v6


#Exit on any command fail
set -e

echo "#################################Disabling existing service..."

echo "#################################Installing dependencies..."
dnf -y install yarn \
    python3 python3-{Levenshtein,setuptools} \
    pip \
    gobject-introspection \
    libwnck3

echo "#################################Cloning..."
mkdir /var/git 2>/dev/null || true
cd /var/git
rm -rf ./Ulauncher 2>/dev/null || true
git clone https://github.com/Ulauncher/Ulauncher.git
cd Ulauncher
git checkout 17c08b6 # The commit I used when first installing and testing

echo "#################################Building..."
rm -rf /usr/share/ulauncher 2>/dev/null || true
mkdir /usr/share/ulauncher
cp -r ./data/* /usr/share/ulauncher/ # Somehow, it will only run if these files are there
./setup.py build
./setup.py install

echo "#################################Running as systemd daemon..."
machinectl shell $SUDO_USER@.host $(which bash) -c "systemctl --user disable ulauncher.service --now 2> /dev/null || true"
cp ./ulauncher.service /usr/lib/systemd/user/ulauncher.service
sed -i 's/\/usr\/bin/\/usr\/local\/bin/'  /usr/lib/systemd/user/ulauncher.service #Install from sources put the bin in /usr/local/bin, not /usr/bin like regular install
#machinectl allows calling a command as a user (we need it because this is a user systemd service).
#$SUDO_USER contains the user calling the sudo command
machinectl shell $SUDO_USER@.host $(which bash) -c "systemctl --user daemon-reload"
machinectl shell $SUDO_USER@.host $(which bash) -c "systemctl --user enable ulauncher.service --now"


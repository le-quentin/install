#!/bin/sh

# Since we don´t share history between tmux panes, history is save when tmux pane is closed.
# It means that if we shutdown the system without killing tmux first, the session history will be lost...
#
# This sets up a systemd unit to kill all tmux panes before shutting down

#Exit on any command fail
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo "#################################Installing script..."
mkdir /usr/local/scripts 2> /dev/null || true
cp "$DIR/kill-tmux.sh" /usr/local/scripts/

echo "#################################Installing systemd service..."
cp "$DIR/run-before-shutdown.service" /etc/systemd/user/run-before-shutdown.service
machinectl shell $SUDO_USER@.host $(which bash) -c "systemctl --user daemon-reload"
machinectl shell $SUDO_USER@.host $(which bash) -c "systemctl --user enable run-before-shutdown.service --now"

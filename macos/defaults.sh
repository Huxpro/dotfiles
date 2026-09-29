#!/usr/bin/env bash
#
# Scripted version of the "MacOS System" tweaks in NEW_MAC.md.
# Idempotent; some settings only take effect after logging out and back in.
#
#   ./macos/defaults.sh

set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "macOS only" >&2
  exit 1
fi

say() { printf '• %s\n' "$*"; }

say "Appearance: Auto (light/dark follows the time of day)"
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

say "Trackpad: tap to click"
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

say "Trackpad: three finger drag"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

say "Keyboard: key repeat instead of the accent popup (hold j in vim/VSCode)"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "Done. Log out and back in for trackpad/keyboard changes to apply."

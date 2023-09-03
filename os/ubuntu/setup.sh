#!/bin/bash

absolute_here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
here="$absolute_here"
root="$here/../.."
#

if [ -f "$HOME/Applications/nvim.appimage" ]; then
  if [ ! -f "/usr/bin/nvim" ]; then
    echo "Symlinking ~/Application/nvim.appimage to /usr/bin/nvim . Will need sudo."
    sudo ln -s ~/Applications/nvim.appimage /usr/bin/nvim
  fi
fi

###############################################
# Load Ubuntu/Gnome Configuration + KeyMappings
###############################################
source "$PWD/os/ubuntu/configs.sh"
# cat home/.config/dconf/user.d/* | dconf load /

# NOTE: to export dconf settings:
# dconf dump / > ~/.config/dconf/user.d/everything.conf

if [ -f "$HOME/Applications/neovide.AppImage" ]; then
  cd "$HOME/Applications"
  echo $PWD
  appimage-to-desktop "neovide" "$HOME/Applications/neovide"
fi


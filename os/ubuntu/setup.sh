#!/bin/bash

absolute_here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
here="$absolute_here"
root="$here/../.."
#

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

# Install our favorite editor!
# Note: this must be in setup.sh instead of install.sh because we need our 
#       $HOME scripts to be in the right place
export PATH="$PATH:$HOME/scripts"
update-neovim

echo ""
echo " --------------------------------------- "
echo "   Finished dotfiles/os/ubuntu/setup.sh  "
echo " --------------------------------------- "
echo ""

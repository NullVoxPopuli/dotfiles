#!/bin/bash
#
echo "Symlinking ~/Application/nvim.appimage to /usr/bin/nvim . Will need sudo."
sudo ln -s ~/Applications/nvim.appimage /usr/bin/nvim

###############################################
# Load Ubuntu/Gnome Configuration + KeyMappings
###############################################
source "$PWD/os/ubuntu/configs.sh"
# cat home/.config/dconf/user.d/* | dconf load /

# NOTE: to export dconf settings:
# dconf dump / > ~/.config/dconf/user.d/everything.conf



#!/bin/bash

TARGET="$HOME/.local/share/applications"
SOURCE="./home/.local/share/applications"

# OBSIDIAN_LOCATION="/Applications/Obsidian-1.1.16.AppImage"

# function getDesktop() {
#   DIR=$(dirname $1)

#   cd $DIR
#   $1 --appimage-extract
#   cd squashfs-root
# }

# TODO: iterate over these 
desktop-file-install --dir=$TARGET "$SOURCE/Obsidian.desktop"


update-desktop-database $TARGET

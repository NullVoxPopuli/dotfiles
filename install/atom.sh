#!/bin/bash

# root of this repo
ROOT_DIR=`git rev-parse --show-toplevel`
ATOM_DIR=~/.atom
PACKAGES_DIR="$ATOM_DIR/packages"
# make sure .atom directory exists
mkdir -p ~/.atom

# copy files
cp "$ROOT_DIR"/home/.atom/* ~/.atom

# install packages
PACKAGES="$ROOT_DIR/home/.atom/packages.list"
while read line; do
  if [ ! -d "$PACKAGES_DIR/$line" ]; then
    apm install $line
    # else
    # echo "$line is already installed"
  fi

done <$PACKAGES

echo "atom is now synced"

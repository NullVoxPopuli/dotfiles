#!/bin/bash

FILES="$PWD/home/.local/share/applications"

mkdir -p ~/.local/share/applications

for filePath in $FILES/*.desktop; do
    [ -e "$filePath" ] || continue

    file=$(basename $filePath)
    rm -f "$HOME/.local/share/applications/$file" 
    ln -s $filePath "$HOME/.local/share/applications/$file" 
done


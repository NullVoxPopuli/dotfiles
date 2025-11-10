#!/usr/bin/env bash


# When installing Google Chrome (or any browser) via the recommended way,
# they fail to add the bin to the PATH.
#
# Google Chrome => google-chrome
# FireFox => firefox
#
# Setting this up is default behavior on Linux, and I'm really surprised
# that macOS continues to be hostile towards developers.
#
# Why do I need this?
#   lots of generic tools expect the browser executables to exist on PATH.
#   (such as test launchers)
#
# This script works by assuming that 
#   /usr/local/bin/
#   is already in PATH
#
#   However, to prevent the need for sudo, we check if 
#   ~/Applications is in PATH, and link to there instead


function addLocalBin() {
  local source=$1
  local name=${2:-"$(basename $source)"}
  local target="/usr/local/bin/$name"

  if ! [ -f "$source" ]; then
    echo "$source not found. Will not link to $name"
    exit 0
  fi

  if [[ $PATH == *"$HOME/Applications"* ]]; then
    target="$HOME/Applications/$name"
  fi

  echo ""
  echo "Symlinking '${source}' to '${target}'"
  
  # NOTE: have to quote due to Google Chrome containing spaces
  ln -sf "$source" "$target"
}


addLocalBin "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "google-chrome"
addLocalBin "/Applications/Firefox.app/Contents/MacOS/firefox"

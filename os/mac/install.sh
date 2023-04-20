#!/bin/bash
#
# NOTE: brew instals are already idempotent (tho, it's not fast)

###############
# Core tools 
###############
brew install bash      # MacOS ships with bash from the dark ages (v3)
brew install starship  # Prompt with git iteration
# https://github.com/alacritty/alacritty/issues/4673#issuecomment-771291615
brew install alacritty # MacOS' terminal is terrible
brew install findutils # MacOS ships with the wrong `find` command
brew install coreutils
brew install neovim    # The one true code editor

##############
# Support for tools
##############
brew install python

###############
# CLI Utils
###############

# Better du
brew install dust # Better du
brew install fzf # Fast fuzzy finding
brew install exa # Better la
brew install bat # Better cat



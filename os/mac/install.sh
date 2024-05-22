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

# i3~ish
#  https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)
brew install koekeishiya/formulae/yabai
# hotkey daemon, recommended by the above
#  https://github.com/koekeishiya/skhd/issues/42#issuecomment-401886533
#  run 
#    brew reinstall skhd to apply settings changes
#    brew services restart skhd
#
# Also,
#   /tmp/skhd.pid may need removing  
brew install koekeishiya/formulae/skhd

##############
# Support for tools
##############
brew install python
brew install jq
brew install gnu-sed
brew install ag
brew install rg
brew install tldr
brew install direnv

###############
# CLI Utils
###############

# Better du
brew install dust # Better du
brew install fzf # Fast fuzzy finding
brew install eza # Better la
brew install bat # Better cat



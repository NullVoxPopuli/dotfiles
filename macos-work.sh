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



##############################################
# Link up config files, and set up directories
##############################################
rm -f ~/.config/alacritty; ln -s $PWD/os/mac/home/.config/alacritty ~/.config/alacritty
rm -f ~/.bashrc; ln -s $PWD/os/mac/home/.bashrc ~/.bashrc

git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# Fix home and end -- How do you do this sytem wide?
bindkey '\e[H'  beginning-of-line
bindkey '\eOH'  beginning-of-line
bindkey '\e[F'  end-of-line
bindkey '\eOF'  end-of-line


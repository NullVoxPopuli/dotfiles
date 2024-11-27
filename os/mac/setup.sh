#!/bin/bash

rm -rf ~/.config/yabai
rm -rf ~/.config/skhd
rm ~/.aerospace.toml

mkdir -p ~/.config/yabai
mkdir -p ~/.config/skhd
mkdir -p ~/.config/borders

ln -s $PWD/os/mac/home/.config/yabai/yabairc ~/.config/yabai/yabairc
ln -s $PWD/os/mac/home/.config/skhd/skhdrc ~/.config/skhd/skhdrc
ln -s $PWD/os/mac/home/.config/borders/bordersrc ~/.config/borders/bordersrc
ln -s $PWD/os/mac/home/.aerospace.toml ~/.aerospace.toml


##############################################
# Link up config files, and set up directories
##############################################
rm -f ~/.config/alacritty; ln -s $PWD/os/mac/home/.config/alacritty ~/.config/alacritty
rm -f ~/.bashrc; ln -s $PWD/os/mac/home/.bashrc ~/.bashrc

rm -fr ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# NOTE: karabiner conflicts with skhd *and* breaks the commands that it overrides
#       (which are needed in the terminal)
#       Do not use karabiner.
# 
# Fix home and end -- How do you do this sytem wide?
# NOTE: bindkey is for zsh, bind for bash
bind '\e[H'  beginning-of-line
bind '\eOH'  beginning-of-line
bind '\e[F'  end-of-line
bind '\eOF'  end-of-line

# Show all files, hidden, etc
# good for .dotfiles
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

# Control = ^
# Shift = $
defaults write NSGlobalDomain NSUserKeyEquivalents '{
    Hide = "@~^$h";
    "New Tab" = "^t";
    "New Window" = "^n";
    "Switch to Channel" = "^k";
    "Find" = "^f";
}'

defaults write -app "Google Chrome" NSUserKeyEquivalents '{
    "Close Tab" = "^w";
    "Reopen Closed Tab" = "^$t";
    "Hide Google Chrome" = "@~^$h";
    "Find\\\\U2026" = "^f";
    "Open Location\\\\U2026" = "^l";
}'

defaults write com.apple.finder NSUserKeyEquivalents '{
    "Go to Folder\\\\U2026" = "^l";
}'


# Disable the shitty workspace-fullscreen behavior that MacOS has
defaults write com.apple.spaces spans-displays -bool true && killall SystemUIServer

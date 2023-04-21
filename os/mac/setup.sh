#!/bin/bash

rm -rf ~/.config/yabai
rm -rf ~/.config/skhd

mkdir -p ~/.config/yabai
mkdir -p ~/.config/skhd

ln -s $PWD/os/mac/home/.config/yabai/yabairc ~/.config/yabai/yabairc
ln -s $PWD/os/mac/home/.config/skhd/skhdrc ~/.config/skhd/skhdrc


##############################################
# Link up config files, and set up directories
##############################################
rm -f ~/.config/alacritty; ln -s $PWD/os/mac/home/.config/alacritty ~/.config/alacritty
rm -f ~/.bashrc; ln -s $PWD/os/mac/home/.bashrc ~/.bashrc

git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# NOTE: karabiner conflicts with skhd *and* breaks the commands that it overrides
#       (which are needed in the terminal)
#       Do not use karabiner.
# 
# Fix home and end -- How do you do this sytem wide?
bindkey '\e[H'  beginning-of-line
bindkey '\eOH'  beginning-of-line
bindkey '\e[F'  end-of-line
bindkey '\eOF'  end-of-line


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
    "Find\\U2026" = "^f";
    "Find\\\\U2026" = "^f";
    "Open Location\\U2026" = "^l";
    "Open Location\\\\U2026" = "^l";
}'

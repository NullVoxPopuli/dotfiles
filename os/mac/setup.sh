#!/bin/bash

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


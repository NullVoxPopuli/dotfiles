#!/bin/bash

#####################
# Install Common Deps
#####################
# quality of life
sudo apt install xclip gufw exa bat libappindicator1 fonts-font-awesome fonts-powerline 

# personal stuff for various projects
sudo apt install gparted audacity
# old / haven't used in a while:
#   clementine
#   veromix
#   kdenlive
#   gimp

# hobby / work stuff
sudo apt install git curl build-essential i3 python3-pip imagemagick fzf

# core dependencies of tools used
sudo apt install sqlite3 libsqlite3-dev

sudo snap install dust
sudo snap install starship

# Volta / node manager
curl https://get.volta.sh | bash

# Vim Deps
sudo apt install silversearcher-ag
pip install neovim
pip3 install neovim
pip3 install --user pynvim


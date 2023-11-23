#!/bin/bash

#####################
# Install Common Deps
#####################
# quality of life
sudo apt install xclip gufw exa bat libappindicator1 fonts-font-awesome fonts-powerline python3-pip

# personal stuff for various projects
sudo apt install gparted audacity
# old / haven't used in a while:
#   clementine
#   veromix
#   kdenlive
#   gimp

# core dependencies of tools used
#  sqlite3 - needed as a storage for some tools
#  cmake - most tools expect this for Makefile support
#  libfuse2 - needed for running AppImage files
#  fzf, ripgrep, silversearcher - (fuzzy) search / finder(s)
#  xdotool - needed by Albert for copying emojis (other automation software uses this as well)
sudo apt install \
  git curl build-essential i3 python3-pip imagemagick \
  sqlite3 libsqlite3-dev cmake libfuse2 \
  fzf ripgrep silversearcher-ag \
  xdotool

sudo snap install dust

# Volta / node manager
curl https://get.volta.sh | bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


# Rust tooling 
curl https://sh.rustup.rs -sSf | sh
# to not require a new terminal, we'll temporarily modify PATH 
source "$HOME/.cargo/env"


# PS1 replacement
# on snapcraft, they haven't released a stable version yet for some reason
# it's also not as up to date as cargo
# sudo snap install --edge starship 
cargo install starship --locked


# Dev and Neovim stuff
volta install node
npm add --global pnpm
npm add --global @fsouza/prettierd cspell typescript
cargo install tree-sitter-cli


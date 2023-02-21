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

# packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

mkdir -p ~/Development/NullVoxPopuli
mkdir -p ~/Development/OpenSource
mkdir -p ~/Development/tmp
mkdir -p ~/Development/Work

mkdir -p ~/.local/share/nvim/_backup
mkdir -p ~/.local/share/nvim/_temp
mkdir -p ~/.local/share/nvim/_undo
mkdir -p ~/.local/share/nvim/spell
mkdir -p ~/.config/
mkdir -p ~/.config/pop-shell/

rm -rf ~/Applications
rm -rf ~/scripts
rm -rf ~/.themes
rm -rf ~/.bash_profile
rm -rf ~/.config/nvim
rm -rf ~/.config/fish

ln -s $PWD/home/Applications ~/Applications
ln -s $PWD/home/scripts ~/scripts
ln -s $PWD/home/shell ~/shell
ln -s $PWD/home/.themes ~/.themes
ln -s $PWD/home/.bash_profile ~/.bash_profile
ln -s $PWD/home/.config/nvim ~/.config/nvim
ln -s $PWD/home/.config/fish ~/.config/fish
ln -s $PWD/home/.config/starship.toml ~/.config/starship.toml
ln -s $PWD/home/.config/pop-shell/config.json ~/.config/pop-shell/config.json
ln -s $PWD/home/.gitmessage ~/.gitmessage
ln -s $PWD/home/.tldrrc ~/.tldrrc

echo "Symlinking ~/Application/nvim.appimage to /usr/bin/nvim . Will need sudo."
sudo ln -s ~/Applications/nvim.appimage /usr/bin/nvim

###############################################
# Load Ubuntu/Gnome Configuration + KeyMappings
###############################################
source ./configs.sh
# cat home/.config/dconf/user.d/* | dconf load /

# NOTE: to export dconf settings:
# dconf dump / > ~/.config/dconf/user.d/everything.conf



###############################################
# Setup Git
###############################################
source ./git-setup.sh

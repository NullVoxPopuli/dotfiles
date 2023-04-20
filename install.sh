unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*) 
      echo "Installing for Linux"
      source "$PWD/os/ubuntu/install.sh"
    ;;
    Darwin*)    
      echo "Installing for Mac"
      source "$PWD/os/mac/install.sh"
    ;;
    *)    
      echo "Unknown OS: $unameOut"
esac


# packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

mkdir -p ~/Development/NullVoxPopuli
mkdir -p ~/Development/OpenSource
mkdir -p ~/Development/OpenSource/emberjs
mkdir -p ~/Development/OpenSource/starbeam
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
rm -rf ~/.config/bat
rm -rf ~/.config/starship.toml
rm -rf ~/.config/pop-shell/config.json
rm -rf ~/.gitmessage
rm -rf ~/.tldrrc


ln -s $PWD/home/Applications ~/Applications
ln -s $PWD/home/scripts ~/scripts
ln -s $PWD/home/shell ~/shell
ln -s $PWD/home/.themes ~/.themes
ln -s $PWD/home/.bash_profile ~/.bash_profile
ln -s $PWD/home/.config/nvim ~/.config/nvim
ln -s $PWD/home/.config/fish ~/.config/fish
ln -s $PWD/home/.config/starship.toml ~/.config/starship.toml
ln -s $PWD/home/.config/bat ~/.config/bat
ln -s $PWD/home/.config/pop-shell/config.json ~/.config/pop-shell/config.json
ln -s $PWD/home/.gitmessage ~/.gitmessage
ln -s $PWD/home/.tldrrc ~/.tldrrc


case "${unameOut}" in
    Linux*) 
      echo "Setup for Linux"
      source "$PWD/os/ubuntu/setup.sh"
    ;;
    Darwin*)    
      echo "Setup for Mac"
      source "$PWD/os/mac/setup.sh"
    ;;
    *)    
      echo "Unknown OS: $unameOut"
esac

###############################################
# Setup Git
###############################################
source ./git-setup.sh

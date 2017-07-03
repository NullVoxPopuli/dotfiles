#####################
# Install Common Deps
#####################
# veromix \
sudo apt install -y \
  git vim curl xclip \
  npm gnupg gparted gufw \
  qt4-qmake qt5-qmake libxslt-dev libxml2-dev \
  audacity clementine \
  gimp kdenlive vlc \
  filezilla etherape gnome \
  libdbus-glib-1-dev \
  i3 \
  libappindicator1 \
  fonts-font-awesome \
  scrot \
  lm-sensors

# Vim Deps
sudo apt install silversearcher-ag

# Vim 8
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install -y vim

#######################
# Install Atom Packages
#######################
apm install \
  aligner aligner-ruby aligner-scss aligner-javascript \
  autoclose-html \
  file-icons \
  git-time-machine blame tree-view-git-status \
  change-case ember-tabs\
  atom-handlebars language-emblem language-slim react \
  linter linter-sass-lint linter-eslint linter-ruby \
  scroll-percentage \
  vim-mode-plus \
  pigments

######################################################
# Setup the trash to be outside of the home directory
# http://dev-notes.eu/2016/07/delete-files-in-atom-under-ubuntu-16-04/
#####################################################
# Create a Trash directory (with some subdirectories) in root
sudo mkdir -p /.Trash-1000/{expunged,files,info}

# Give ownership of this to your user:
sudo chown -R $USER /.Trash-1000

###############################################
# Load Ubuntu/Gnome Configuration + KeyMappings
###############################################
cat home/.config/dconf/user.d/* | dconf load /

# NOTE: to export dconf settings:
# dconf dump / > ~/.config/dconf/user.d/everything.conf

###########################
# Copy home directory stuff
###########################
cp home/.atom/* ~/.atom -R
cp home/.i3 ~/ -R
cp home/.vim ~/ -R
cp home/scripts ~/ -R
cp home/.bash_profile ~/
cp home/.tmux.conf ~/
cp home/.vimrc ~/

####################
# sync Atom
####################
# apm install
# ./install/atom.sh

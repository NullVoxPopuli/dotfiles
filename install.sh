#####################
# Install Common Deps
#####################
sudo apt install \
  git vim curl xclip \
  npm gnupg gparted gufw \
  qt4-qmake qt5-qmake libxslt-dev libxml2-dev \
  veromix audacity clementine \
  gimp kdenline vlc \
  filezilla etherape gnome \
  libdbus-glib-1-dev \
  i3 \
  libappindicator1 \
  fonts-font-awesome \
  scrot \
  lm-sensors

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

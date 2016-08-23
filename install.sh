###############################################
# Load Ubuntu/Gnome Configuration + KeyMappings
###############################################
cat home/.config/dconf/user.d/* | dconf load /

# NOTE: to export dconf settings:
# dconf dump / > ~/.config/dconf/user.d/everything.conf

###########################
# Copy home directory stuff
###########################
mkdir ~/.atom
cp home/.atom/* ~/.atom -R
cp home/.i3 ~/ -R
cp home/.vim ~/ -R
cp home/scripts ~/ -R
cp home/.bash_profile ~/
cp home/.tmux.conf ~/
cp home/.vimrc ~/

####################
# sync Atom Packages
####################
apm install package-sync

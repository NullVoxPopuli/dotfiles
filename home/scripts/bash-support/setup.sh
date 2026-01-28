unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*) 
      # Specifically for gnome-terminal
      eval `dircolors -b`
    ;;
    Darwin*)    
      # MacOS *really* wants us to use zsh.
      # I don't want to.
      export BASH_SILENCE_DEPRECATION_WARNING=1
    ;;
    *)    
      echo "Unknown OS: $unameOut"
esac


# Disable hostname completion entirely
# This prevents "@" from needing to be escaped in the terminal due to
# @::1  @broadcosthost @localhost
#
# Seems to only be on macos? we'll see what happens on linux later today
shopt -u hostcomplete

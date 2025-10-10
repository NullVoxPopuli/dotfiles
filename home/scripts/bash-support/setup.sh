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



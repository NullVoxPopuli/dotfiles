unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*) 
      # Specifically for gnome-terminal
      eval `dircolors -b`
    ;;
    Darwin*)    
    ;;
    *)    
      echo "Unknown OS: $unameOut"
esac


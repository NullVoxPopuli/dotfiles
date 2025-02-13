unameOut="$(uname -s)"

# Requires eza 
# https://github.com/eza-community/eza
# sudo apt install eza
#
# to use old ls, /usr/bin/ls -- which ls
alias ls='eza -h'
alias la="eza -lah"


case "${unameOut}" in
    Linux*) 
      # Requires bat https://github.com/sharkdp/bat
      # sudo apt install bat
      #
      # to use old cat, /usr/bin/cat -- which cat
      alias cat="batcat"

      # Clipboard
      # What can we use for wayland/sway?
      if [ "$XDG_SESSION_DESKTOP" == "hyprland" ]; then
        alias setclip='wl-copy'
        alias getclip='wl-paste'
      else
        alias setclip='xclip -selection c'
        alias getclip='xclip -selection clipboard -o'
      fi
    ;;
    Darwin*)    
      # Requires bat https://github.com/sharkdp/bat
      # brew install bat 
      #
      # to use old cat, /bin/cat -- which cat
      alias cat="bat"

      # brew install gnu-sed, installs as gsed
      alias sed="gsed"

      # brew install findutils, instals find as gfind
      alias find="gfind"

      # Clipboard
      alias setclip='pbcopy'
      alias getclip='pbpaste'

    ;;
    *)    
      echo "Unknown OS: $unameOut"
esac


# Requires dust https://github.com/bootandy/dust
# sudo snap install dust
# or install deb from releases page
#
# to use old du, /user/bin/du -- which du
alias du="dust"

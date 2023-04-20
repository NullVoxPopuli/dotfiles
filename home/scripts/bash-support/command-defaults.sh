unameOut="$(uname -s)"

# Requires exa https://the.exa.website/
# sudo apt install exa
#
# to use old ls, /usr/bin/ls -- which ls
alias ls='exa -h'
alias la="exa -lah"


case "${unameOut}" in
    Linux*) 
      # Requires bat https://github.com/sharkdp/bat
      # sudo apt install bat
      #
      # to use old cat, /usr/bin/cat -- which cat
      alias cat="batcat"
    ;;
    Darwin*)    
      # Requires bat https://github.com/sharkdp/bat
      # brew install bat 
      #
      # to use old cat, /bin/cat -- which cat
      alias cat="bat"
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

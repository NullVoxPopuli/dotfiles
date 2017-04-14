 # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
 # This loads nvm
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"
# allows git usage in PS1
[[ -s "$HOME/scripts/bash-support/git-prompt.sh" ]] && source "$HOME/scripts/bash-support/git-prompt.sh"
# Extend our path, include scripts, etc
[[ -s "$HOME/scripts/bash-support/paths.sh" ]] && source "$HOME/scripts/bash-support/paths.sh"
# allows having the current command running as the title of your terminal window
[[ -s "$HOME/scripts/bash-support/current-command.sh" ]] && source "$HOME/scripts/bash-support/current-command.sh"
# custom PS1, configure by commenting out PS1= lines
[[ -s "$HOME/scripts/bash-support/ps1.sh" ]] && source "$HOME/scripts/bash-support/ps1.sh"

# handy aliases
alias ll="ls -l"
alias la="ls -la"
alias ccat='$HOME/scripts/vimcat'

# Git
alias gs='git status'
alias gd='git diff'
alias gls='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'

# Ruby
alias be='bundle exec'

# Docker
alias docko="docker-compose"
alias docker-stop-all="docker stop $(docker ps -a -q)"
alias docker-clean='docker rm -v $(docker ps -a -q -f status=exited) && docker volume rm $(docker volume ls -qf dangling=true)'
alias docker-destroy='\
  sudo docker kill $(docker ps -q); \
  sudo docker rm $(docker ps -a -q); \
  sudo docker rmi $(docker images -q -f dangling=true); \
  sudo docker rmi $(docker images -q -f) -f;'

# Clipboard
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# tab completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# colors!
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

export NVM_DIR="$HOME/.nvm"

# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
# Prevents Ctrl+s and Ctrl+q from haulting vim sessions
stty -ixon

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

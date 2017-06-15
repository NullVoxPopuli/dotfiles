# Load the Ruby Loader
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

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
eval `dircolors -b`
alias ls='ls --color=auto'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll="ls -l"
alias la="ls -la"

# Git
alias gc='git checkout'
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias gbs='git branch-status'
alias gb='git branch'
alias gls='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'

# Python
alias gmusic='cd ~/Development/etkirsch/gmusic && python gmusic.py'

# Ruby
alias be='bundle exec'

# Docker
alias docko="docker-compose"
alias docker-stop-all="docker stop $(docker ps -a -q)"
alias docker-clean='\
  docker rm -v $(docker ps -a -q -f status=exited) && \
  docker volume rm $(docker volume ls -qf dangling=true); \
  docker rm $(docker ps -a -q); \
  docker rmi $(docker images -q -f dangling=true); \
  docker rmi $(docker images -q -f) -f; \
  docker volume rm $(docker volume ls -q)'

alias docker-destroy='\
  sudo docker kill $(docker ps -q); \
  sudo docker rm $(docker ps -a -q); \
  sudo docker rmi $(docker images -q -f dangling=true); \
  sudo docker rmi $(docker images -q -f) -f; \
  sudo docker volume rm $(docker volume ls -q)'

alias ccat='$HOME/scripts/vimcat'

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

### Cargo / Rust
export PATH="$HOME/.cargo/bin:$PATH"



# http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_EXCLUDE=".git,node_modules,.gem,vendor/gems,bower_components,tmp"
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow -g \"!{$FZF_EXCLUDE}/*\" 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'

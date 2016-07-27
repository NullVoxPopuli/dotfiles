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
alias docko="docker-compose"

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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# allows git usage in PS1
source "$HOME/scripts/bash-support/git-prompt.sh"
# Extend our path, include scripts, etc
source "$HOME/scripts/bash-support/paths.sh"
# allows having the current command running as the title of your terminal window
source "$HOME/scripts/bash-support/current-command.sh"
# custom PS1, configure by commenting out PS1= lines
source "$HOME/scripts/bash-support/ps1.sh"

# Apps (these are really just aliases, though, and don't augment the PATH
[[ -s "$HOME/Applications/paths.sh" ]] && source "$HOME/Applications/paths.sh"

export EDITOR=nvim
export PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'

# handy aliases
shopt -s expand_aliases

eval `dircolors -b`
alias ls='ls --color=auto -h'
alias dir='ls --color=auto --format=vertical -h'
alias vdir='ls --color=auto --format=long -h'
alias ll="ls -lh"
alias la="ls -lah"
alias ng="nuke-gently"
alias dotfiles='cd $HOME/Development/NullVoxPopuli/dotfiles'

# Git
alias gc='git checkout'
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias gbs='git branch-status'
alias gb="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

alias gls='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'
alias gia='git add --patch'
alias gp='git push --follow-tags --atomic'
alias g-reset-master="git fetch origin && git checkout master && git reset origin/master --hard"
alias ggraph='git log master --graph --format="%C(auto) %h %s"'

alias herpderp='ember'

# Docker
alias docko="docker-compose"

# Clipboard
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
# Prevents Ctrl+s and Ctrl+q from haulting vim sessions
stty -ixon

### Cargo / Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Python....
export PATH="$HOME/.pythons/Python-3.6.3/bin:$PATH"


# http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_EXCLUDE=".git,node_modules,.gem,vendor/gems,bower_components,tmp,dist,obj,bin"
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow -g \"!{$FZF_EXCLUDE}/*\" 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="bfs -type d -nohidden"

bind -x '"\C-p": vim $(fzf);'


export VOLTA_HOME="/home/preston/.volta"
grep --silent "$VOLTA_HOME/bin" <<< $PATH || export PATH="$VOLTA_HOME/bin:$PATH"

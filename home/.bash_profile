SCRIPTS="$HOME/scripts"
# NOTE: see also $HOME/.local/share/applications/
APPS="$HOME/Applications"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$APPS"

# Extend our path, include scripts, etc
source "$SCRIPTS/bash-support/paths.sh"
# allows having the current command running as the title of your terminal window
source "$SCRIPTS/bash-support/current-command.sh"
# Override common commands such as ls, cat, etc
source "$SCRIPTS/bash-support/command-defaults.sh"

# Apps (these are really just aliases, though, and don't augment the PATH
[[ -s "$APPS/paths.sh" ]] && source "$APPS/paths.sh"

export EDITOR=nvim
export PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'
export NODE_OPTIONS='--trace-warnings --unhandled-rejections=strict'
export DEV="$HOME/Development"
export OSS="$DEV/OpenSource"
export GG_PATHS="$DEV/NullVoxPopuli:$DEV/tmp:$DEV/Work:$OSS:$OSS/emberjs:$OSS/starbeam"
export GG_PREFIX="$HOME/Development/"
export COPILOT="true"
export PRETTIERD_LOCAL_PRETTIER_ONLY=1

# Utilities, etc
source "$HOME/shell/bash/npm.sh"
source "$HOME/shell/bash/gg.sh"
source "$HOME/shell/bash/github-action-runner.sh"
source "$HOME/shell/bash/git.sh"

# handy aliases
shopt -s expand_aliases

eval `dircolors -b`
alias dotfiles='cd $HOME/Development/NullVoxPopuli/dotfiles'
# for copying error outputs to github
alias unme-clip="getclip | unme | setclip"
# cleaning js+ts projects
alias nuke="\
  echo \"nukin' node_modules & declaration directories\" \
  && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' + \
  && find . -name 'declarations' -type d -prune -exec rm -rf '{}' + \
  && find . -name '.turbo' -type d -prune -exec rm -rf '{}' + \
  "

# Git
alias grt='cd $(git rev-parse --show-toplevel)'
alias gs='git status'
alias gl="git log --graph --pretty=tformat:'%Cred%h%Creset - %<(100,trunc)%s%w(0,0,14)%+Cgreen(%cr) %Cblue<%aN>%Creset%C(auto)%w(0,0,14)%<(100,trunc)%+D%C(reset)'"
alias gd='git diff'
alias ga="git add --patch"
alias gbs='git branch-status'

alias gia='git add --patch'
alias gorigin="git branch -rl '*/HEAD' | rev | cut -d/ -f1 | rev"
alias g-reset="git remote set-head origin -a && git fetch origin && git checkout \$(gorigin) && git reset origin/\$(gorigin) --hard"
alias ggraph='git log master --graph --format="%C(auto) %h %s"'
alias idgaf="git checkout origin/\$(gorigin) \$(git diff --name-only --diff-filter=U --relative)"

# Clipboard
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
# Prevents Ctrl+s and Ctrl+q from haulting vim sessions
# But only do this when running an interactive shell
# [[ $- == *i* ]] && stty -ixon


###############################################################################
##
## Conditional environment augmentations
##
###############################################################################
# on MacOS, brew must be loaded first
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Prompt by starship
# https://starship.rs/guide/#%F0%9F%9A%80-installation
if ! [ -x "$(command -v starship)" ]; then
  echo "Starship command not found. Check script before uncommenting"
  echo ""
  echo "\tRunning external script. Be careful."
  echo "\t curl -fsSL https://starship.rs/install.sh | bash"
else
  eval "$(starship init bash)"
fi


# http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash

  export FZF_DEFAULT_COMMAND="\
    rg --files --no-ignore --hidden --follow \
    -g \"!tmp/\" \
    -g \"!node_modules\" \
    -g \"!declarations\" \
    -g \"!dist\" \
    -g \"!.git\/\" \
    2> /dev/null"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="bfs -type d -nohidden"
fi

### Cargo / Rust
if [ -f "$HOME/.cargo/env" ]; then 
  source "$HOME/.cargo/env"
fi
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"

  # Ruby version manager
  if [ -f "$HOME/.cargo/bin/frum" ]; then
    eval "$(frum init)"
  fi
fi

# https://volta.sh/
if [ -d "$HOME/.volta" ]; then 
  export VOLTA_FEATURE_PNPM=1
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# Deno is a node alternative
if [ -d "$HOME/.deno" ]; then 
  export DENO_INSTALL="/home/nvp/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi


# Python....
if [ -d "$HOME/.pythons" ]; then
  export PATH="$HOME/.pythons/Python-3.6.3/bin:$PATH"
fi

# pnpm
if [ -x "$(pnpm --version)" ]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi


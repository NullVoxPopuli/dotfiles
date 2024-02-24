# Overwritten by starship
# export PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'
export NODE_OPTIONS='--trace-warnings --unhandled-rejections=strict'

# Navigating repos
export DEV="$HOME/Development"
export OSS="$DEV/OpenSource"
export GG_PATHS="$DEV/NullVoxPopuli:$DEV/tmp:$DEV/Work:$OSS:$OSS/emberjs:$OSS/starbeam"
export GG_PREFIX="$HOME/Development/"

# Editor
export EDITOR=nvim
export COPILOT="true"
export PRETTIERD_LOCAL_PRETTIER_ONLY=1

# Sehcuurrity 
export GPG_TTY=$(tty)

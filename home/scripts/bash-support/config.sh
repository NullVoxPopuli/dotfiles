# Overwritten by starship
# export PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'
# Must forward incoming $NODE_OPTIONS 
# for use in VSCode's JavaScript Debug Terminal
export NODE_OPTIONS="--trace-deprecation --trace-warnings --unhandled-rejections=strict $NODE_OPTIONS"

# Because we work in so many projects, 
# we don't want to set this if a project doesn't have it.
export COREPACK_ENABLE_AUTO_PIN=0

# Navigating repos
export DEV="$HOME/Development"
export OSS="$DEV/OpenSource"

GG_PATHS="$DEV/NullVoxPopuli:$DEV/tmp:$DEV/Work:$OSS" 
export GG_PATHS="$GG_PATHS:$OSS/emberjs:$OSS/starbeam"

export GG_PREFIX="$HOME/Development/"

# Editor
export EDITOR=nvim
export COPILOT="true"
export PRETTIERD_LOCAL_PRETTIER_ONLY=1
# export MANPAGER="nvim +Man!"

# Sehcuurrity 
export GPG_TTY=$(tty)

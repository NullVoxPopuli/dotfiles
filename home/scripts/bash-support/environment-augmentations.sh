###############################################################################
##
## Conditional environment augmentations
##
###############################################################################
unameOut="$(uname -s)"


# on MacOS, brew must be loaded first
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Prompt by starship
# https://starship.rs/guide/#%F0%9F%9A%80-installation
if ! [ -x "$(command -v starship)" ]; then
  echo "Starship command not found. Please install"
  echo ""
  echo "Linux: cargo install starship"
  echo "Mac: brew install starship"
else
  case "${unameOut}" in
    Linux*)
    function set_win_title(){
      DIRNAME2=$(basename "$(dirname "$PWD")")/$(basename "$PWD")
      echo -ne "\033]0; $DIRNAME2 \007"
    }

    # starship adds to this
    export PROMPT_COMMAND="$PROMPT_COMMAND;set_win_title"
    ;;
  esac

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

# https://mise.jdx.dev/
# https://github.com/jdx/mise
#
# NOTE: you still need to manually run `corepack enable pnpm`
#       and even then, pnpm won't be available unless the packageManager says so.
#       So pnpm will need to be installed globally (via npm)
if [ -f "$HOME/.local/bin/mise" ]; then 
  # If installing via the downloaded shell script
  export MISE_NODE_COREPACK=1
  eval "$(~/.local/bin/mise activate bash)"
elif [ -n "$(which mise)" ]; then 
  # If installing via apt 
  export MISE_NODE_COREPACK=1
  eval "$(mise activate bash)"
fi

# https://asdf-vm.com
if [ -d "$HOME/.asdf" ]; then 
  echo "WARNING: detected asdf @ ~/.asdf -- Don't use this."
fi

# Deno is a node alternative
if [ -d "$HOME/.deno" ]; then 
  export DENO_INSTALL="/home/nvp/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

# Bun is a node alternative
if [ -d "$HOME/.bun/bin" ]; then
  export PATH="$HOME/.bun/bin:$PATH"
fi


# Python....
if [ -d "$HOME/.pythons" ]; then
  export PATH="$HOME/.pythons/Python-3.6.3/bin:$PATH"
fi

# pnpm
if [ -n "$(which pnpm)" ] && [ -x "$(pnpm --version)" ]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi


# Werk
if [ -f "$HOME/.bash_profile.werk" ]; then 
  source "$HOME/.bash_profile.werk"
fi

# pip3 (as well as other tools installs things here
if [ -d "$HOME/.local/bin" ]; then 
  export PATH="$HOME/.local/bin:$PATH"
fi

# Bun (node, but faster)

# bun
if [ -d "$HOME/.bun" ]; then 
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

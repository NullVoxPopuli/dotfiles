### Cargo / Rust
if [ -f "$HOME/.cargo/env" ]; then 
  source "$HOME/.cargo/env"
fi

# We only care if we also have Rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"

  # Ruby version manager
  if [ -f "$HOME/.cargo/bin/frum" ]; then
    eval "$(frum init)"
  fi
fi

# https://volta.sh/ 
if [ -d "$HOME/.volta" ]; then 
  echo "WARNING: detected volta @ ~/.volta -- Don't use this."
  export VOLTA_FEATURE_PNPM=1
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# https://moonrepo.dev/proto
# https://github.com/moonrepo 
#
# Alternative to Mise, Volta, asdf
# Uses Shims, like Volta and asdf
if [ -d "$HOME/.proto" ]; then
  export PROTO_HOME="$HOME/.proto";
  export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH";
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

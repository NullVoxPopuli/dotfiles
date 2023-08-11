PATH="$HOME/scripts:$PATH"
PATH="$HOME/scripts/rails:$PATH"
PATH="$HOME/scripts/git:$PATH"
PATH="$HOME/scripts/node:$PATH"
PATH="$HOME/scripts/system-utils:$PATH"
PATH="$HOME/apps/phantomjs/bin:$PATH"
PATH="$HOME/Applications:$PATH"

# NOTE: see also $HOME/.local/share/applications/
APPS="$HOME/Applications"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:$APPS"

# Apps (these are really just aliases, though, and don't augment the PATH
[[ -s "$APPS/paths.sh" ]] && source "$APPS/paths.sh"


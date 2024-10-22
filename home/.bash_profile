SCRIPTS="$HOME/scripts"

# Any initial things before we get in to running scripts
source "$SCRIPTS/bash-support/setup.sh"

# Extend our path, include scripts, etc
source "$SCRIPTS/bash-support/paths.sh"
# Override common commands such as ls, cat, etc
source "$SCRIPTS/bash-support/command-defaults.sh"
# Config, defaults, etc 
source "$SCRIPTS/bash-support/config.sh"
source "$SCRIPTS/bash-support/aliases.sh"

# Utilities, etc
source "$HOME/shell/bash/npm.sh"
source "$HOME/shell/bash/gg.sh"
source "$HOME/shell/bash/github-action-runner.sh"
source "$HOME/shell/bash/git.sh"

source "$SCRIPTS/bash-support/tooling-managers.sh"
source "$SCRIPTS/bash-support/environment-augmentations.sh"
. "$HOME/.cargo/env"

#!/usr/bin/env bash
#
# Install the privileged half of keyboard-indicator.
#
# These two files are COPIED rather than symlinked into the repo, on purpose.
# pkexec itself would happily follow a symlink -- it does no ownership or
# permission check on the program, only access(path, F_OK). The problem is the
# policy: it grants allow_active=yes, i.e. root with no password. If the file
# pkexec executes (or the .policy that authorises it) were writable by $USER,
# then anything running as $USER could append a line to it and silently become
# root. Root-owned copies close that.
#
# Cost of that: the repo is the source of truth, but edits don't take effect
# until this is re-run. `install.sh check` reports when the two have drifted.

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

script_src="$here/kbd-internal-toggle"
script_dst=/usr/local/bin/kbd-internal-toggle

policy_src="$here/org.nullvoxpopuli.kbd-internal-toggle.policy"
policy_dst=/usr/share/polkit-1/actions/org.nullvoxpopuli.kbd-internal-toggle.policy

up_to_date() {
  local ok=0
  for pair in "$script_src:$script_dst" "$policy_src:$policy_dst"; do
    local src="${pair%%:*}" dst="${pair##*:}"
    if [ ! -e "$dst" ]; then
      echo "missing:  $dst"
      ok=1
    elif ! cmp -s "$src" "$dst"; then
      echo "outdated: $dst"
      ok=1
    fi
  done
  return $ok
}

if [ "${1:-install}" = "check" ]; then
  if up_to_date; then
    echo "keyboard-indicator helper is up to date"
  else
    echo "run $0 to reinstall"
    exit 1
  fi
  exit 0
fi

sudo install -m 0755 -o root -g root "$script_src" "$script_dst"

# polkitd watches this directory, so the action is picked up without a restart
sudo install -m 0644 -o root -g root "$policy_src" "$policy_dst"

echo "installed. built-in keyboard is currently: $("$script_dst" status)"




function DEBUG_NODE() {
  export NODE_OPTIONS='--trace-warnings --unhandled-rejections=strict --inspect-brk'

  eval $@
}

function node-why() {
  local dep=$1
  local here="$(dirname "${BASH_SOURCE[0]}")"

  $here/../../scripts/node/node-why.mjs $dep
}

function pscripts() {
  cat package.json | jq '.scripts'
}

function latestPkgVer() {
  local result=$(pnpm info $1 --json)
  echo ""
  echo ""

  echo "Current:"
  echo $result | jq '.version'
  echo ""

  echo "Tags:"
  echo $result | jq '.["dist-tags"]'
  echo ""

  echo "Most Recent:"
  echo $result | jq '.versions[-1]'
  echo ""
}

# This only works if the workspaces root is the git root
function reduceLock() {
  local git_root=$(git rev-parse --show-toplevel) 

  if [ -z "$git_root" ]; then 
    echo "Not in a repository"
    return 1
  fi

  if [[ -f "pnpm-lock.yaml" ]]; then 
    local upstream_branch=$(git symbolic-ref refs/remotes/origin/HEAD --short)

    echo "Reducing lockfile..."
    echo ""

    cd $git_root
    git checkout $upstream_branch -- pnpm-lock.yaml
    pnpm install
    # This should be automatic, but it isn't always. I don't know why.
    # Ideally, and hopefully the average case, it's a no-op
    pnpm dedupe

    echo ""
    echo "Done."

    return 0
  else
    echo "Only pnpm is supported"
    return 1
  fi
}

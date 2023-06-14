function DEBUG_NODE() {
  export NODE_OPTIONS='--trace-warnings --unhandled-rejections=strict --inspect-brk'

  eval $@
}

function node-why() {
  local dep=$1

  echo ""
  echo "Node resolves $dep from $PWD to: "
  echo ""
  node -e "console.log(require.resolve('$dep'))"
  echo ""
}

function pscripts() {
  cat package.json | jq '.scripts'
}

function latestPkgVer() {
  local result=$(yarn info $1 --json)
  echo ""
  echo ""

  echo "Current:"
  echo $result | jq '.data.version'
  echo ""

  echo "Tags:"
  echo $result | jq '.data["dist-tags"]'
  echo ""

  echo "Most Recent:"
  echo $result | jq '.data.versions[-1]'
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
    local upstream_branch="origin/$(gorigin)" 

    echo "Reducing lockfile..."
    echo ""

    cd $git_root
    git checkout $upstream_branch -- pnpm-lock.yaml
    pnpm install

    echo ""
    echo "Done."

    return 0
  else
    echo "Only pnpm is supported"
    return 1
  fi
}

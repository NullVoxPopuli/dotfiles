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

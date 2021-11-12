function DEBUG_NODE() {
  export NODE_OPTIONS='--trace-warnings --unhandled-rejections=strict --inspect-brk'

  eval $@
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

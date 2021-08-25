# vi:foldmethod=marker
#!/bin/bash

# prints a nice formatted list of recent git branches
function gb() {
  local count=$1;
  local terminal=/dev/pts/1
  local columns=$(stty -a <"$terminal" | grep -Po '(?<=columns )\d+')

  git for-each-ref \
    --sort=-committerdate refs/heads \
    --format='%(color:red)%(objectname:short)%(color:reset)|%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)' \
    --color=always \
    --count=${count:=30} \
  | column -t -s'|' \
  | tac \
  | cut -c 1-$columns
}

# Interactive git checkout (recent branches)
function gcr() {
  if [[ -n "$1" ]]; then
    local QUERY="--query $1"
  fi

  # gb defined as alias above
  local selected=$(gb | fzf --delimiter="  " --nth=1,2 --tac --ansi -1 $QUERY)
  local selected_branch=$(echo $selected | cut -d' ' -f2)

  git checkout $selected_branch
}

# vi:foldmethod=marker
#!/bin/bash

# prints a nice formatted list of recent git branches
function gb() {
  local count=$1;
  local columns=$(tput cols)

  git for-each-ref \
    --sort=-committerdate refs/heads \
    --format='%(color:red)%(objectname:short)%(color:reset)|%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)' \
    --color=always \
    --count=${count:=30} \
  | column -t -s'|' \
  | tac \
  | cut -c 1-$columns
}

function werk() {
  local sha="$(uuid | cut -d - -f 1)"
  local branchName="${1:-"$sha"}"
  local upstream=$(git symbolic-ref refs/remotes/origin/HEAD --short)

  branchName="nvp/$(echo $branchName | sed -E 's/nvp\///g')"

  echo "Starting new work on $branchName branched off $upstream"

  git switch -c $branchName $upstream
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

function g-authoredBy() {
  local author=$1
  local time_ago=${2:-"1 day ago"}

  git log \
    --pretty="%H" \
    --author="$author" \
    --since="$(date --date "$time_ago")" \
    | while read commit_hash; \
      do git show --oneline --name-only $commit_hash \
        | tail -n+2; \
      done \
    | sort \
    | uniq
}

# Rebasing with less typing
#
# @examples
#   smoosh
#     - finds the point the branch started, and loads all those commits in interactive rebase
#
#   smoosh 2
#     - interactive rebase over the 2 most recent commits
function smoosh() {
  function determineSmooshability() {
    local sourceBranch=$()

    git rev-list --count HEAD^$sourceBranch
  }

  local numCommitsToSmoosh=${1:-$(determineSmooshability)}

  git rebase -i HEAD~$numCommitsToSmoosh
}

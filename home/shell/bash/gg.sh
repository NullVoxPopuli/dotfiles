# vi:foldmethod=marker
#!/bin/bash
#
# NOTE: this file must be sourced into your bash_profile, otherwise
#       this script cannot change the calling shell's current directory
#
# gg: short for go-g{e,i}t
#
#     For jumping to a git repo anywhere on your system, because cd takes too long
#
# Requires: fzf, jq, yarn
#     npm workspaces are not supported because I don't use them
#     due to bugs with npm's workspaces implementation
#
# Requires: GIT_PATHS be set
#     Example:
#        GIT_PATHS="$HOME/Development/NullVoxPopuli:$HOME/Development/Work:$HOME/Code"
#
# Setting GIT_PATHS in your .bash_profile will allow gg to search git repos amoung all colon-separated
# directories.
#
# Optionally, you may set GG_PREFIX, which will remove the path substring from all
# query prompts. This is handy if your sources have a lengthy root path
#
# There are 3 steps:
#   1. Choose a repo -- will be skipped if you are already in a repo
#   2. Choose a worktree -- will be skipped if you have no worktrees
#   3. Choose a sub-project -- will be skipped if you are already in one, or your repo is not a monorepo

function gg() {

  # Import Dependencies {{{
  helpers="$(dirname "${BASH_SOURCE[0]}")/../../scripts/-helpers"

  source "$helpers/colors.sh"
  # }}}

  # Validations {{{

  if [[ -z "${GG_PATHS}" ]]; then
    error "environment variable, GIT_PATHS, is not set."
    error "set GIT_PATHS to paths that point to collections if git repos"
    error "example:"
    error '  GIT_PATHS="$HOME/Development/NullVoxPopuli:$HOME/Development/OpenSource:$HOME/Development/Work"'
    return
  fi

  # }}}

  # Constants & Setup {{{

  PREFIX="${GG_PREFIX:-$HOME}"

  search_text=$1

  if [[ -n "$search_text" ]]; then
    QUERY="--query $search_text"
  fi

  function print_workspaces() {
    yarn workspaces --json info --json | jq '.data' -r | jq 'map(.location) | .[]' -r
  }

  # }}}

  # Select Repo {{{

  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true" ]]; then
    # Ask to choose a repo
    PREV_IFS=$IFS; IFS=':'; path_array=($GG_PATHS); IFS=$PREV_IFS;


    function print_repos() {
      for i in "${path_array[@]}"; do
        readarray -t dirs < <(find $i -mindepth 1 -maxdepth 1 -type d -printf '%P\n')

        for j in "${dirs[@]}"; do
          absolute_path="$i/$j"
          relative_path=$(echo $absolute_path | sed "s#$PREFIX##")

          echo $relative_path
        done
      done
    }

    selected_repo=$(print_repos | fzf \
      -1 \
      --with-nth=1 \
      $QUERY \
    )

    if [ "$selected_repo" == "" ]; then
      echo "No repo selected"
      return 0
    fi

    cd "$PREFIX/$selected_repo"

    QUERY=""
  fi

  # }}}


  num_worktrees=$( git worktree list | wc -l )

  if [ "$num_worktrees" -gt "1" ]; then
    # Ask to choose a worktree

    function print_worktrees() {
      PREV_IFS=$IFS; IFS=$'\n'; full_worktrees=($(git worktree list)); IFS=$PREV_IFS;

      for i in "${full_worktrees[@]}"; do
        trimmed=$(echo $i | sed "s#$PREFIX##")
        echo $trimmed
      done
    }

    selected_worktree=$(print_worktrees | fzf \
      -1 \
      $QUERY \
    )

    selected_worktree=$(echo $selected_worktree | cut -f 1 -d ' ')

    if [  "$selected_worktree" == "" ]; then
      return 0
    fi

    cd "$PREFIX$selected_worktree"

    QUERY=""
  fi

  package_path="$(pwd)/package.json"
  workspace_config=$(cat $package_path | jq '.workspaces')

  if [ "$workspace_config" != "null" ]; then
    # Ask to choose a workspace
    selected_workspace=$(print_workspaces | fzf \
      -1 \
      --with-nth=1 \
      $QUERY \
      | cut -f2 \
    )

    if [ "$selected_workspace" == "" ]; then
      return 0
    fi

    cd $selected_workspace

    QUERY=""
  fi

}

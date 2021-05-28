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

  if [[ -z "${GIT_PATHS}" ]]; then
    error "environment variable, GIT_PATHS, is not set."
    error "set GIT_PATHS to paths that point to collections if git repos"
    error "example:"
    error '  GIT_PATHS="$HOME/Development/NullVoxPopuli:$HOME/Development/OpenSource:$HOME/Development/Work"'
    exit 1
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
    IFS=':'; path_array=($GIT_PATHS); unset IFS;


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
      | cut -f2 \
    )


    cd "$PREFIX/$selected_repo"

    QUERY=""
  fi

  # }}}


  return 1

  num_worktrees=$( git worktree list | wc -l )

  if [ "$num_worktrees" -gt "1" ]; then
    # Ask to choose a worktree

    cd $selected_worktree

    QUERY=""
  fi

  workspace_config=$(cat package.json | jq '.workspaces')

  # num_workspaces=$(yarn workspaces --json info | jq '.data' -r | jq 'keys' | jq length)

  if [[ "$workspace_config" == "null" ]]; then
    # Ask to choose a workspace
    selected_workspace=$(print_workspaces | fzf \
      -1 \
      --with-nth=1 \
      $QUERY \
      | cut -f2 \
    )

    cd $selected_workspace

    QUERY=""
  fi

}

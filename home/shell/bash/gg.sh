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
# Requires: fzf, jq, and yarn or pnpm
#     npm workspaces are not supported because I don't use them
#     due to bugs with npm's workspaces implementation
#
#     additionally, the workspace root must also be the git root.
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

# debug
# set -ex

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
  SKIP_WORKTREES="false"
  ESCAPE_REPO="false"
  QUERY=""

  search_text=$1

  if [[ -n "$search_text" ]]; then
    QUERY="--query $search_text"
  fi


  for arg in "$@"
  do
    case "$arg" in
      --skip-worktrees)
        SKIP_WORKTREES="true"
        ;;
      --escape)
        ESCAPE_REPO="true"
        ;;
      *)
        # ignore
        ;;
    esac
  done

  function print_workspaces() {
    root_of_repo=$(git rev-parse --show-toplevel)

    yarnlock="$root_of_repo/yarn.lock"
    pnpmlock="$root_of_repo/pnpm-lock.yaml"

    if [ -f "$pnpmlock" ]; then

      workspaces_info=$(pnpm ls -r --depth -1 --long --json)
      repo_relative=$(echo "$workspaces_info" | jq 'map(.path |= sub("'"$root_of_repo"'/"; ""))')
      echo $repo_relative | jq -r '(.[] | [.name, .path]) | @tsv'

      # See: https://github.com/pnpm/pnpm/issues/3398
      #
      # Line-by-line:
      #   Remove version information
      #   Remove the current directory
      #   Remove empty lines
      #   Remove leading slashes
      # pnpm ls -r --depth -1 --long --parseable \
      #   | cut -f1 -d':' \
      #   | sed "s~$root_of_repo~~g" \
      #   | sed '/^[[:space:]]*$/d' \
      #   | sed 's~^/~~g'
    elif [ -f "$yarnlock" ]; then
      yarn workspaces --json info --json | jq '.data' -r | jq 'map(.location) | .[]' -r
    else
      echo 'Unsupported workspaces tool.'
      return 1;
    fi
  }

  function has_workspaces() {
    root_of_repo=$(git rev-parse --show-toplevel)

    yarnlock="$root_of_repo/yarn.lock"
    pnpm_file="$root_of_repo/pnpm-workspace.yaml"

    if [ -f $pnpm_file ]; then
      echo 'yes'
    elif [ -f $yarnlock ]; then
      echo "$(cat $package_path | jq '.workspaces')"
    else
      echo 'Unsupported workspaces tool.'
    fi


  }

  # }}}

  # Select Repo {{{

  is_in_repo=$(git rev-parse --is-inside-work-tree 2>/dev/null)

  if [[ "$is_in_repo" != "true" || $ESCAPE_REPO == "true" ]]; then
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
      --no-hscroll \
      --no-mouse \
      --height=60% \
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

  # Select Worktree {{{

  if [ "$SKIP_WORKTREES" == "false" ]; then
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
        --no-hscroll \
        --no-mouse \
        --height=60% \
        $QUERY \
      )

      selected_worktree=$(echo $selected_worktree | cut -f 1 -d ' ')

      if [  "$selected_worktree" == "" ]; then
        return 0
      fi

      cd "$PREFIX$selected_worktree"

      QUERY=""
    fi
  fi

  # }}}

  # Select Workspace {{{

  root_of_repo=$(git rev-parse --show-toplevel)
  package_path="$root_of_repo/package.json"

  package_json_exists=$(cat $package_path 2>/dev/null)

  if [ -z "$package_json_exists" ]; then
    info "Current repo is not a JavaScript project"
    info "To escape outside of this repo use 'ggo'"
    return 1;
  fi

  workspace_config=has_workspaces

  if [ "$workspace_config" != "null" ]; then
    # Ask to choose a workspace
    #  The "print_workspaces" string should be formatted as:
    #  
    #    package-name             package-path
    selection=$(print_workspaces | column -t -s $'\t' | fzf \
      -1 \
      --no-hscroll \
      --no-mouse \
      --height=60% \
      $QUERY \
      | cut -f2 \
    )

    selected_workspace="$(echo $selection | awk -v FPAT='[^[:space:]]+' '{print $2}')"

    if [ "$selected_workspace" == "" ]; then
      # fallback for single-column print_workspaces
      selected_workspace=$selection
    fi

    if [ "$selected_workspace" == "" ]; then
      return 0
    fi

    if [[ "$selected_workspace" =~ $root_of_repo ]]; then
      # workspace is full path
      cd $selected_workspace
    else
      # workspace is relative to root
      cd "$root_of_repo/$selected_workspace"
    fi


    QUERY=""
  fi

  # }}}

}

alias ggi="gg '' --skip-worktrees"
alias ggo="gg '' --escape"
alias ggr="gg '' --escape"

# vi:foldmethod=marker
#!/bin/bash
#
# Runs a script from package.json.
# Could later be expanded to run any type of project, but I mostly do 
# JavaScript dev right now.
#
# NOTE: this file must be sourced into your bash_profile, otherwise
#       this script cannot change the calling shell's current directory
#
# Requires: fzf, jq, and pnpm 

function print_package_manifest_scripts() {
  local manifestPath=$1
  if [ -f "$manifestPath" ]; then
    cat $1 \
      | jq -r '.scripts' \
      | jq -r 'to_entries | map([.key, .value])[] | @tsv' \
      | column -t -s $'\t' 
      # | awk -F '\t' "{printf \"${EMB}%s${NC}\t${G}%s${NC}\n\", \$1, \$2}"
  else
    echo "No package.json found at $manifestPath"
  fi

}


function run() {
  local manifestPath="$PWD/package.json"

  # Import Dependencies (globally available) {{{
  helpers="$(dirname "${BASH_SOURCE[0]}")/../../scripts/-helpers"

  source "$helpers/colors.sh"
  # }}}

  if [ -f "$manifestPath" ]; then
    local selected_row=$(print_package_manifest_scripts $manifestPath \
      | fzf --delimiter=" " --ansi --tac --nth=1,2 -1 \
      --no-hscroll \
      --no-mouse \
      --height=60% \
    )

    if [  "$selected_row" == "" ]; then
      return 0
    fi

    local selected=$(echo $selected_row | cut -d' ' -f1)

    echo "Running:"
    echo -e "  ${EMC}pnpm run ${selected}${NC}"

    pnpm run $selected;
  else
    echo "No package.json found at $manifestPath"
  fi
}

# handy aliases
shopt -s expand_aliases

alias dotfiles='cd $HOME/Development/NullVoxPopuli/dotfiles'
# for copying error outputs to github
alias unme-clip="getclip | unme | setclip"
# cleaning js+ts projects
alias nuke="\
  echo \"nukin' stuff\" \
  && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' + \
  && find . -name 'declarations' -type d -prune -exec rm -rf '{}' + \
  && find . -name 'dist' -type d -prune -exec rm -rf '{}' + \
  && find . -name '.turbo' -type d -prune -exec rm -rf '{}' + \
  "

# Git
alias ope='git commit -am"ope"'
alias grt='cd $(git rev-parse --show-toplevel)'
alias gs='git status'
alias gl="git log --graph --pretty=tformat:'%Cred%h%Creset - %<(100,trunc)%s%w(0,0,14)%+Cgreen(%cr) %Cblue<%aN>%Creset%C(auto)%w(0,0,14)%<(100,trunc)%+D%C(reset)'"
alias gd='git diff'
alias ga="git add --patch"
alias gbs='git branch-status'

alias gia='git add --patch'
alias gorigin="git branch -rl '*/HEAD' | rev | cut -d/ -f1 | rev"
alias g-reset="git remote set-head origin -a && git fetch origin && git checkout \$(gorigin) && git reset origin/\$(gorigin) --hard"
alias ggraph='git log master --graph --format="%C(auto) %h %s"'
alias idgaf="git checkout origin/\$(gorigin) \$(git diff --name-only --diff-filter=U --relative)"

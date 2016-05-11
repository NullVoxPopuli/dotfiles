PATH="$HOME/scripts:$PATH"
PATH="$HOME/scripts/rails:$PATH"
PATH="$HOME/scripts/system-utils:$PATH"
PATH="$HOME/apps/phantomjs/bin:$PATH"
# make sure that node
[[ -s "$(which node)" ]] && PATH="$(npm bin):$PATH"

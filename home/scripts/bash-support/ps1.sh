
function __current_ruby_ps1 {
	local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
	[ "$gemset" != "" ] && gemset="@$gemset"
	local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
	[ "$version" == "1.8.7" ] && version=""
	local full="$version$gemset"
	[ "$full" != "" ] && echo "💎  $full"
}

function __current_node_ps1 {
        local node_exists=$(which node)

        if [ -n "$node_exists" ]
        then
                local version=$(node --version)
                [ "$version" != "" ] && echo "⬡ $version "
        fi
}

function __ip_address_ps1 {
	hostname -I
}

custom_bash_prompt(){
	# regular colors
	local K="\[\033[0;30m\]"    # black
	local R="\[\033[0;31m\]"    # red
	local G="\[\033[0;32m\]"    # green
	local Y="\[\033[0;33m\]"    # yellow
	local B="\[\033[0;34m\]"    # blue
	local M="\[\033[0;35m\]"    # magenta
	local C="\[\033[0;36m\]"    # cyan
	local W="\[\033[0;37m\]"    # white

	# emphasized (bolded) colors
	local EMK="\[\033[1;30m\]"
	local EMR="\[\033[1;31m\]"
	local EMG="\[\033[1;32m\]"
	local EMY="\[\033[1;33m\]"
	local EMB="\[\033[1;34m\]"
	local EMM="\[\033[1;35m\]"
	local EMC="\[\033[1;36m\]"
	local EMW="\[\033[1;37m\]"

	# username@hostname
	export PS1="$EMM\u$EMG@$EMC\h "

	# ip address
	# export PS1="$PS1$C\$(__ip_address_ps1) "

	# current directory
	export PS1="$PS1$EMB\w"

	# newline
	export PS1="$PS1\n"


	# current node
	export PS1="$PS1$G\$(__current_node_ps1)"

	# current ruby
	export PS1="$PS1$R\$(__current_ruby_ps1)"

	# current git branch
	export PS1="$PS1$Y\$(__git_ps1) "

	# little end bit
	export PS1="$PS1$G\$ $W"
}

custom_bash_prompt

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If running interactively, then:
if [ "$PS1" ]; then

	# don't put duplicate lines in the history. See bash(1) for more options
	# export HISTCONTROL=ignoredups

	# enable color support of ls and also add handy aliases
	eval `dircolors -b`
	alias ls='ls --color=auto'
	alias dir='ls --color=auto --format=vertical'
	alias vdir='ls --color=auto --format=long'

fi;

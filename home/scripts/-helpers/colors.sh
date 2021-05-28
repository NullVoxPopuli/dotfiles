#!/bin/bash

# regular colors
K="\033[30m"    # black
R="\033[31m"    # red
G="\033[32m"    # green
Y="\033[33m"    # yellow
B="\033[34m"    # blue
M="\033[35m"    # magenta
C="\033[36m"    # cyan
W="\033[37m"    # white
NC='\033[0m' # No Color

# emphasized (bolded) colors
EMK="\033[1;30m"
EMR="\033[1;31m"
EMG="\033[1;32m"
EMY="\033[1;33m"
EMB="\033[1;34m"
EMM="\033[1;35m"
EMC="\033[1;36m"
EMW="\033[1;37m"

function warn() {
  echo -e "$EMY$1$NC"
}

function debug() {
  echo -e "$K$1$NC"
}

function info() {
  echo -e "$B$1$NC"
}

function yay() {
  echo -e "$EMG$1$NC"
}

function error() {
  echo -e "$EMR$1$NC"
}

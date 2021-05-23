#!/bin/bash

msg=$1

read -d '' warningMessage << END
  !!! WARNING !!!

  $1

  Confirm? (Y|N)
END

while true; do
    read -p "$warningMessage" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit 1;;
        * ) echo "Please answer yes or no.";;
    esac
done

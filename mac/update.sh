#!/bin/zsh

set -e

print_title() {
  echo "$*"
}

print_message() {
  echo "> $*"
}

print_title Update Homebrew and packages ...
brew upgrade -v
print_message "Done\n"

print_title Update zplug packages ...
export ZPLUG_HOME=/usr/local/opt/zplug
. $ZPLUG_HOME/init.zsh
LANG=en_US.UTF-8 zplug update
print_message "Done\n"

print_title "Use prefix + U to updates tpm plugin(s)"
print_message "Done\n"

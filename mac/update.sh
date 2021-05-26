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

print_title "Use 'LANG=en_US.UTF-8 zplug update' to update zplug package(s)"
print_message "Done\n"

print_title "Use prefix + U to updates tpm plugin(s)"
print_message "Done\n"

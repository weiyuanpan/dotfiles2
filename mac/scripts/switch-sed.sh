#!/bin/sh

set -e

print_title() {
  echo "$*"
}

print_message() {
  echo "> $*"
}

CURRENT_SED_PATH=$(which sed)

if [ "$CURRENT_SED_PATH" = "/usr/bin/sed" ]; then
  print_message "Switch MacOS sed => GNU sed"
  mv "/usr/local/opt/gnu-sed/libexec/gnubin/sed.disabled" "/usr/local/opt/gnu-sed/libexec/gnubin/sed"
  mv "/usr/local/opt/gnu-sed/libexec/gnuman/man1.disabled" "/usr/local/opt/gnu-sed/libexec/gnuman/man1"
elif [ "$CURRENT_SED_PATH" = "/usr/local/opt/gnu-sed/libexec/gnubin/sed" ]; then
  print_message "Switch GNU sed => MacOS sed"
  mv "/usr/local/opt/gnu-sed/libexec/gnubin/sed" "/usr/local/opt/gnu-sed/libexec/gnubin/sed.disabled"
  mv "/usr/local/opt/gnu-sed/libexec/gnuman/man1" "/usr/local/opt/gnu-sed/libexec/gnuman/man1.disabled"
fi

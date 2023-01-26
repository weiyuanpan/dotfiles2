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
  mv "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin/sed.disabled" "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin/sed"
  mv "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman/man1.disabled" "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman/man1"
elif [ "$CURRENT_SED_PATH" = "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin/sed" ]; then
  print_message "Switch GNU sed => MacOS sed"
  mv "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin/sed" "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin/sed.disabled"
  mv "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman/man1" "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman/man1.disabled"
fi

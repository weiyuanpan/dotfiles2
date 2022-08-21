#!/bin/sh

set -ex

if [ ! -d ~/.hammerspoon/Spoons/VimMode.spoon ]; then
  git clone https://github.com/dbalatero/VimMode.spoon \
    ~/.hammerspoon/Spoons/VimMode.spoon
fi


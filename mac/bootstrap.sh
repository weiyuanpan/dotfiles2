#!/bin/sh

set -e

print_title() {
  echo "$*"
}

print_message() {
  echo "> $*"
}

DONE_DIR=$HOME/.done
mkdir -p "$DONE_DIR"
USERNAME=weiyuanpan
#USERNAME=$(id -un)
PLATFORM_DIR="$(cd "$(dirname "$0")"; pwd -P)" # absolute path
#PLATFORM_DIR=$(dirname "$0")

# ssh preparation
SSH_DIR="$HOME"/.ssh
SSH_DONE_FILE=$DONE_DIR/ssh.done
if test ! -f "$SSH_DONE_FILE"
then
  print_title Prepare SSH ...

  #rm -rf "$SSH_DIR"
  mkdir -p "$SSH_DIR"
  chmod 700 "$SSH_DIR"
  cp "$PLATFORM_DIR"/ssh/* "$SSH_DIR"/
  #chmod 600 "$SSH_DIR"/*
  touch "$SSH_DONE_FILE"

  print_message "Done\n"
fi

# create github src folder
GITHUB_SRC_DIR="$HOME"/src/github/$USERNAME
GITHUB_DONE_FILE=$DONE_DIR/github.done
if test ! -f "$GITHUB_DONE_FILE"
then
  print_title Prepare GitHub source directroy ...

  #rm -rf "$GITHUB_SRC_DIR"
  mkdir -p "$GITHUB_SRC_DIR"
  touch "$GITHUB_DONE_FILE"

  print_message "Done\n"
fi

# install Homebrew
HOMEBREW_DONE_FILE=$DONE_DIR/homebrew.done
if test ! -f "$HOMEBREW_DONE_FILE"
then
  print_title Install Homebrew ...

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew --version
  touch "$HOMEBREW_DONE_FILE"

  print_message "Done\n"
fi

# install Brewfile
BREWFILE_DONE_FILE=$DONE_DIR/brewfile.done
if test ! -f "$BREWFILE_DONE_FILE"
then
  print_title Install applications in Brewfile ...

  cd "$PLATFORM_DIR"
  if [ -f "Brewfile" ]; then
      brew bundle -v
      cd -
      touch "$BREWFILE_DONE_FILE"
  else
      print_message "Brewfile not found"
      cd -
  fi

  print_message "Done\n"
fi

# install oh-my-zsh
OH_MY_ZSH_DONE_FILE=$DONE_DIR/oh-my-zsh.done
if test ! -f "$OH_MY_ZSH_DONE_FILE"
then
  print_title Install Oh My Zsh ...

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  touch "$OH_MY_ZSH_DONE_FILE"

  print_message "Done\n"
fi

# prepare .zshrc
ZSHRC_DONE_FILE=$DONE_DIR/zshrc.done
if test ! -f "$ZSHRC_DONE_FILE"
then
  print_title Prepare .zshrc ...

  test -f "$HOME"/.zshrc && mv "$HOME"/.zshrc "$HOME"/.zshrc.old
  ln -s "$PLATFORM_DIR"/.zshrc "$HOME"/.zshrc
#  cp -a "$PLATFORM_DIR"/.zshrc "$HOME"/.zshrc
  touch "$ZSHRC_DONE_FILE"

  print_message "Done\n"
fi

# install powerline fonts
POWERLINE_FONTS_DONE_FILE=$DONE_DIR/powerline-fonts.done
POWERLINE_FONTS_DIR=/tmp/fonts
if test ! -f "$POWERLINE_FONTS_DONE_FILE"
then
  print_title Install Powerline Fonts ...

  git clone https://github.com/powerline/fonts.git --depth=1 $POWERLINE_FONTS_DIR
  cd $POWERLINE_FONTS_DIR
  ./install.sh
  cd -
  touch "$POWERLINE_FONTS_DONE_FILE"

  print_message "Done\n"
fi

# install tmux config
TMUX_CONF_DONE_FILE=$DONE_DIR/tmux-conf.done
if test ! -f "$TMUX_CONF_DONE_FILE"
then
  print_title Install tmux config ...

  cd "$PLATFORM_DIR"
  ./tmux/install.sh
  cd -
  touch "$TMUX_CONF_DONE_FILE"

  print_message "Done\n"
fi

# install hammerspoon spoons
SPOONS_DONE_FILE=$DONE_DIR/spoons.done
if test ! -f "$SPOONS_DONE_FILE"
then
  print_title Install hammerspoon spoons ...

  rm -f "$HOME/.hammerspoon"
  ln -sf "$PLATFORM_DIR/hammerspoon" "$HOME/.hammerspoon"

  cd "$PLATFORM_DIR"
  ./hammerspoon/install.sh
  cd -
  touch "$SPOONS_DONE_FILE"

  print_message "Done\n"
fi

print_message "Some other installations are available\n"
print_message "e.g. ~/.dotfiles/python/install.sh, ~/.dotfiles/node/install.sh ...\n"

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

# install base utils
UTILS_DONE_FILE=$DONE_DIR/utils.done
if test ! -f "$UTILS_DONE_FILE"
then
  print_title Install base utilities ...

  sudo apt update
  sudo apt-get install --no-install-recommends git make gcc build-essential \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl \
    llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
    liblzma-dev python-is-python3 vim network-manager-l2tp network-manager-l2tp-gnome \
    neofetch gnome-tweaks vlc gimp wireshark fcitx fcitx-mozc fcitx-googlepinyin wmctrl \
    xdg-utils xclip
  touch "$UTILS_DONE_FILE"

  print_message "Done\n"
fi

# install zsh
ZSH_DONE_FILE=$DONE_DIR/zsh.done
if test ! -f "$ZSH_DONE_FILE"
then
  print_title Install Zsh ...

  sudo apt update
  sudo apt-get -y install zsh
  print_message "Use zsh as default shell\n"
  chsh -s "$(which zsh)"
  if test ! -f "$HOME/.zshrc"
  then
    echo "# .zshrc dummy" > $HOME/.zshrc
  fi
  touch "$ZSH_DONE_FILE"

  print_message "Done\n"
  print_message "Please restart bootstrap.sh after using Zsh\n"
  exit 0
fi

# install Homebrew
HOMEBREW_DONE_FILE=$DONE_DIR/homebrew.done
if test ! -f "$HOMEBREW_DONE_FILE"
then
  print_title Install Homebrew ...

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if grep '/home/linuxbrew/.linuxbrew/bin/brew shellenv' $HOME/.zprofile;
  then
    print_message "Homebrew path have been set\n"
  else
    print_message "Set Homebrew path"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zprofile
  fi
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
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
  brew bundle -v
  cd -
  touch "$BREWFILE_DONE_FILE"

  print_message "Done\n"
fi

# install 1password-beta for linux
ONE_PASS_BETA_DONE_FILE=$DONE_DIR/1password-beta.done
if test ! -f "$ONE_PASS_BETA_DONE_FILE"
then
  print_title Install 1password-beta for linux ...

  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo apt-key add -
  echo 'deb [arch=amd64] https://downloads.1password.com/linux/debian/amd64 beta main' | sudo tee /etc/apt/sources.list.d/1password-beta.list
  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
  sudo apt update && sudo apt install 1password
  touch "$ONE_PASS_BETA_DONE_FILE"

  print_message "Done\n"
fi

# install sublime
SUBLIME_DONE_FILE=$DONE_DIR/sublime.done
if test ! -f "$SUBLIME_DONE_FILE"
then
  print_title Install Sublime ...

  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo apt-get install apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update
  sudo apt-get install sublime-text
  touch "$SUBLIME_DONE_FILE"

  print_message "Done\n"
fi

# install docker
DOCKER_DONE_FILE=$DONE_DIR/docker.done
DOCKER_COMPOSE_VERSION=1.29.1
if test ! -f "$DOCKER_DONE_FILE"
then
  print_title Install Docker ...

  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
  sudo usermod -aG docker $USERNAME
  sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  touch "$DOCKER_DONE_FILE"

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
  cp -a "$PLATFORM_DIR"/.zshrc "$HOME"/.zshrc
  touch "$ZSHRC_DONE_FILE"

  print_message "Done\n"
fi

# install powerline fonts
POWERLINE_FONTS_DONE_FILE=$DONE_DIR/powerline-fonts.done
if test ! -f "$POWERLINE_FONTS_DONE_FILE"
then
  print_title Install Powerline Fonts ...

  sudo apt update
  sudo apt-get install fonts-powerline
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

sudo apt autoremove

print_message "Some other installations are available\n"
print_message "e.g. ~/.dotfiles/python/install.sh, ~/.dotfiles/node/install.sh ...\n"

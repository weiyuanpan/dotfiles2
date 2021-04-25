#!/usr/bin/env bash

set -e
set -u
set -o pipefail

is_app_installed() {
  type "$1" &>/dev/null
}

REPO_DIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPO_DIR";

if ! is_app_installed tmux; then
  printf "WARNING: \"tmux\" command is not found. \
Install it first\n"
  exit 1
fi

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  printf "WARNING: Cannot found TPM (Tmux Plugin Manager) \
 at default location: \$HOME/.tmux/plugins/tpm.\n"
  git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
fi

if [ -e "$HOME/.tmux.conf" ]; then
  printf "Found existing .tmux.conf in your \$HOME directory. Will create a backup at %s/.tmux.conf.bak\n" "$HOME"
fi

cp -f "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak" 2>/dev/null || true
cp -a ./conf/. "$HOME"/.tmux/
cp -a ./bin/. "$HOME"/.tmux/
ln -sf .tmux/tmux.conf "$HOME"/.tmux.conf;

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
	printf "WARNING: Cannot found TPM (Tmux Plugin Manager) \
		at default location: \$HOME/.tmux/plugins/tpm.\n"
	git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm

	# Install TPM plugins.
	# TPM requires running tmux server, as soon as `tmux start-server` does not work
	# create dump __noop session in detached mode, and kill it when plugins are installed
	printf "Install TPM plugins\n"
	tmux new -d -s __noop >/dev/null 2>&1 || true
	tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins"
	"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
	tmux kill-session -t __noop >/dev/null 2>&1 || true
fi

printf "OK: Completed\n"

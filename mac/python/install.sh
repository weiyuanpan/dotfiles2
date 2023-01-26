#!/bin/sh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

#pyenv install -v 3.7.6
#pyenv install -v 3.5.4
#pyenv global system
#pyenv virtualenv 3.7.6 PcwlAPI-openwrt-v2
#pyenv virtualenv 3.5.4 PcwlAPI-bhclinux-v1
pyenv versions

cat <<'EOF'>> $HOME/.zprofile
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
EOF


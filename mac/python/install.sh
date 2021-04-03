#!/bin/sh

pyenv install -v 3.7.6
pyenv install -v 3.5.4
pyenv global system
pyenv virtualenv 3.7.6 PcwlAPI-openwrt-v2
pyenv virtualenv 3.5.4 PcwlAPI-bhclinux-v1
pyenv versions

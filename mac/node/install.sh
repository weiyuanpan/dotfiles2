#!/bin/sh

nvm install --lts
nvm use --lts
nvm alias default "lts/*"
nvm ls

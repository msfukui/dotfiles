#!/bin/bash -f

if [ ! -d "${HOME}/.ndenv/bin" ]; then
  echo "[error] ndenv is not set up."
  exit 1
fi

setup_nodejs_version=4.4.7

export PATH="$HOME/.ndenv/bin:$PATH"
eval "$(ndenv init -)"

ndenv rehash
ndenv install ${setup_nodejs_version}
ndenv global ${setup_nodejs_version}
ndenv rehash
node -v

npm install -g npm-check-updates
ndenv rehash
ncu -v

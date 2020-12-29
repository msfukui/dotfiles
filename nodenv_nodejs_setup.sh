#!/bin/bash

if [ ! -d "${HOME}/.nodenv/bin" ]; then
  echo "[error] nodenv is not set up."
  exit 1
fi

setup_nodejs_version=10.15.3

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

nodenv rehash
nodenv install ${setup_nodejs_version}
nodenv global ${setup_nodejs_version}
nodenv rehash
node -v

npm install -g npm-check-updates
nodenv rehash
ncu --version

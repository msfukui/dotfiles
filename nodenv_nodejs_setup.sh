#!/bin/bash

if [ ! -d "${HOME}/.nodenv/bin" ]; then
  echo "[error] nodenv is not set up."
  exit 1
fi

if [ $# -gt 0 ]; then
  setup_nodejs_version=$1
else
  setup_nodejs_version=14.16.1
fi
echo "setup_nodejs_version: $setup_nodejs_version"

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

#!/bin/bash

if [ ! -d "${HOME}/.pyenv/bin" ]; then
  pushd ${HOME}
  git clone https://github.com/pyenv/pyenv .pyenv
  popd
fi

#!/bin/bash

if [ ! -d "${HOME}/.nodenv/bin" ]; then
  pushd ${HOME}
  git clone https://github.com/nodenv/nodenv .nodenv
  popd
fi

if [ ! -d "${HOME}/.nodenv/plugins/node-build" ]; then
  mkdir -p ${HOME}/.nodenv/plugins
  pushd ${HOME}/.nodenv/plugins
  git clone https://github.com/nodenv/node-build ${HOME}/.nodenv/plugins/node-build
  popd
fi


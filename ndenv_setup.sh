#!/bin/bash -f

if [ ! -d "${HOME}/.ndenv/bin" ]; then
  pushd ${HOME}
  git clone https://github.com/riywo/ndenv .ndenv
  popd
fi

if [ ! -d "${HOME}/.ndenv/plugins/node-build" ]; then
  mkdir -p ${HOME}/.ndenv/plugins
  pushd ${HOME}/.ndenv/plugins
  git clone https://github.com/riywo/node-build ${HOME}/.ndenv/plugins/node-build
  popd
fi

#!/bin/bash -f

if [ ! -d "${HOME}/.rbenv/bin" ]; then
  pushd ${HOME}
  git clone https://github.com/sstephenson/rbenv.git .rbenv
  popd
fi

if [ ! -d "${HOME}/.rbenv/plugins/ruby-build" ]; then
  mkdir -p ${HOME}/.rbenv/plugins
  pushd ${HOME}/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git
  popd
fi

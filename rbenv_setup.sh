#!/bin/bash -f

if [ ! -d "${HOME}/.rbenv/bin" ]; then
  pushd ${HOME}
  git clone https://github.com/sstephenson/rbenv.git .rbenv
  popd
else
  pushd ${HOME}/.rbenv
  git pull origin master
  popd
fi

if [ ! -d "${HOME}/.rbenv/plugins/ruby-build" ]; then
  mkdir -p ${HOME}/.rbenv/plugins
  pushd ${HOME}/.rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git
  popd
else
  pushd ${HOME}/.rbenv/plugins/ruby-build
  git pull origin master
  popd
fi

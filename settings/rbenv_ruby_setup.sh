#!/bin/bash

if [ ! -d "${HOME}/.rbenv/bin" ]; then
  echo "[error] rbenv is not set up."
  exit 1
fi

if [ ! -d "${HOME}/.rbenv/plugins/ruby-build" ]; then
  echo "[error] rbenv-ruby-build is not set up."
  exit 2
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Update rbenv && ruby-build.
pushd ${HOME}/.rbenv
git pull origin master
popd
pushd ${HOME}/.rbenv/plugins/ruby-build
git pull origin master
popd

if [ $# -gt 0 ]; then
  setup_ruby_version=$1
else
  setup_ruby_version=`rbenv install --list | awk '{print $1}' | egrep "^[0-9]+\.[0-9]+\.[0-9]+$" | tail -1`
fi
echo "setup_ruby_version: $setup_ruby_version"

rbenv rehash
# for macports
if [ -x /opt/local/bin/port ]; then
  RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/local --with-libyaml-dir=/opt/local --with-gmp-dir=/opt/local" rbenv install ${setup_ruby_version}
else
  rbenv install ${setup_ruby_version}
fi
rbenv global ${setup_ruby_version}
rbenv rehash

gem update --system
gem update
rbenv rehash

gem install rubocop --no-document
rbenv rehash

ruby -v
gem -v
rubocop -v

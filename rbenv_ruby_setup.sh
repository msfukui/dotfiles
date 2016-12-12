#!/bin/bash -f

if [ ! -d "${HOME}/.rbenv/bin" ]; then
  echo "[error] rbenv is not set up."
  exit 1
fi

setup_ruby_version=2.3.3

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

rbenv rehash
rbenv install ${setup_ruby_version}
rbenv global ${setup_ruby_version}
rbenv rehash
ruby -v

gem update --system
gem update
rbenv rehash
gem -v

gem install bundler pry rubocop --no-ri --no-rdoc
rbenv rehash
bundle -v
pry -v
rubocop -v

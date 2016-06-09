#!/bin/bash -f

if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if [ ! -d ~/.rbenv/plugins/ruby-build ]; then
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

source ~/.bashrc

rbenv rehash
rbenv install 2.3.1
rbenv global 2.3.1
rbenv rehash
ruby -v

gem update --system
gem update
gem -v

gem install bundler pry rubocop
bundle -v
pry -v
rubocop -v

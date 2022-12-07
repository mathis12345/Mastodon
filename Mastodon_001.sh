#!/bin/bash

apt-get update

apt-get upgrade -y

apt-get install software-properties-common dirmngr apt-transport-https ca-certificates redis-server curl gcc g++ make imagemagick ffmpeg libpq-dev libxml2-dev libxslt1-dev file git-core libprotobuf-dev protobuf-compiler pkg-config autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev libidn11-dev libicu-dev libjemalloc-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev -y

curl -sL https://deb.nodesource.com/setup_16.x | bash -

apt-get install nodejs -y

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt-get update -y

apt-get install yarn -y

apt-get install postgresql postgresql-contrib -y

sudo -u postgres bash <<EOF
echo "In"

psql

CREATE USER mastodon CREATEDB;

EOF
echo "Out"

adduser --disabled-login --gecos 'mastodon' mastodon

chmod 777 /var

chmod 777 /var/lib

chmod 777 /var/lib/gems

chmod 777 /var/lib/gems/2.7.0

chmod 777 /usr

chmod 777 /usr/bin

chmod 777 /usr/bin/rbenv

chmod 777 /root

chmod 777 /root/Mastodon

chmod 777 /usr

chmod 777 /usr/local

chmod 777 /usr/local/bin

chmod 777 /home

chmod 777 /home/mastodon

chmod 777 /home/mastodon/*

sudo -u mastodon bash <<EOF
echo "In"

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

cd ~/.rbenv && src/configure && make -C src

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

echo 'eval "$(rbenv init -)"' >> ~/.bashrc

exec bash

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

RUBY_CONFIGURE_OPTS=--with-jemalloc rbenv install 3.0.3

rbenv global 3.0.3

gem update --system

gem install bundler --no-document

ruby --version

git clone https://github.com/tootsuite/mastodon.git ~/live

cd ~/live

git checkout $(git tag -l | grep -v 'rc[0-9]*$' | sort -V | tail -n 1)

bundle config deployment 'true'

bundle config without 'development test'

bundle install -j$(getconf _NPROCESSORS_ONLN)

yarn install --pure-lockfile

RAILS_ENV=production bundle exec rake mastodon:setup

EOF
echo "Out"

#!/bin/bash

apt-get update

apt-get upgrade -y

apt install -y fwupd libfwupd2 libfwupdplugin5

apt install -y ruby-dev

apt install -y curl wget gnupg apt-transport-https lsb-release ca-certificates

curl -sL https://deb.nodesource.com/setup_16.x | bash -

wget -O /usr/share/keyrings/postgresql.asc https://www.postgresql.org/media/keys/ACCC4CF8.asc

echo "deb [signed-by=/usr/share/keyrings/postgresql.asc] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/postgresql.list

apt update

apt install -y imagemagick ffmpeg libpq-dev libxml2-dev libxslt1-dev file git-core g++ libprotobuf-dev protobuf-compiler pkg-config nodejs gcc autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev nginx redis-server redis-tools postgresql postgresql-contrib certbot python3-certbot-nginx libidn11-dev libicu-dev libjemalloc-dev

corepack enable

yarn set version classic

adduser --disabled-login mastodon

apt install rbenv -y

chmod 777 /var

chmod 777 /var/lib

chmod -R 777 /var/lib/gems

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

sudo -u mastodon bash << EOF
echo "In"

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

cd ~/.rbenv && src/configure && make -C src

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

echo 'eval "$(rbenv init -)"' >> ~/.bashrc

exec bash

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

RUBY_CONFIGURE_OPTS=--with-jemalloc rbenv install 3.0.4

rbenv global 3.0.4

gem install bundler --no-document

EOF
echo "Out"

sudo -u postgres bash << EOF
echo "In"

psql

CREATE USER mastodon CREATEDB;

EOF
echo "Out"

sudo -u mastodon bash << EOF
echo "In"

git clone https://github.com/mastodon/mastodon.git /home/mastodon/live && cd /home/mastodon/live

git checkout $(git tag -l | grep -v 'rc[0-9]*$' | sort -V | tail -n 1)

bundle config deployment 'true'

bundle config without 'development test'

bundle install -j$(getconf _NPROCESSORS_ONLN)

yarn install --pure-lockfile

EOF
echo "Out"

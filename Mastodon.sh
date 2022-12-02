apt-get update

apt-get upgrade -y

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

sudo -u mastodon bash << EOF
echo "In"

sudo chmod 777 /usr

sudo chmod 777 /usr/bin

sudo chmod 777 /usr/bin/rbenv

sudo chmod 777 /root

sudo chmod 777 /root/Mastodon

RUBY_CONFIGURE_OPTS=--with-jemalloc rbenv install 3.0.4

rbenv global 3.0.4

sudo chmod 777 /var

sudo chmod 777 /var/lib

sudo chmod 777 /var/lib/gems

sudo chmod 777 /var/lib/gems/2.7.0

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

git clone https://github.com/mastodon/mastodon.git live && cd live

git checkout $(git tag -l | grep -v 'rc[0-9]*$' | sort -V | tail -n 1)

bundle config deployment 'true'

bundle config without 'development test'

bundle install -j$(getconf _NPROCESSORS_ONLN)

yarn install --pure-lockfile

RAILS_ENV=production bundle exec rake mastodon:setup

EOF 
echo "Out"

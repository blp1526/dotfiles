#!/bin/bash
set -ux

# only root privilege
if [ $(whoami) != root ]; then
  exit
fi

# add user
user=user
grep ^$user: /etc/passwd
if ! [ $? -eq 0 ]; then
  adduser $user
  passwd $user
  gpasswd -a $user wheel
fi

# package manager
fedora_version=$(cat /etc/redhat-release | awk '{ print $3 }')
if [ $fedora_version -gt 21 ]; then
  manager=dnf
else
  manager=yum
fi

$manager update -y

# basic
$manager install -y man
$manager install -y vim
$manager install -y git
$manager install -y tig
$manager install -y tmux
$manager install -y gcc-c++
$manager install -y automake
$manager install -y autoconf
$manager install -y strace
$manager install -y man-pages-ja
$manager install -y the_silver_searcher

# code reading
$manager install -y patch
$manager install -y ccache
$manager install -y ncurses-devel
$manager install -y ctags

# golang
$manager install -y go

# web+db
$manager install -y nginx
$manager install -y mariadb
$manager install -y mariadb-server
$manager install -y mariadb-devel
$manager install -y sqlite
$manager install -y sqlite-devel

# AMQP
$manager install -y rabbitmq-server

# KVM
$manager -y install -y qemu-kvm
$manager -y install -y qemu-kvm-tools

# ruby
$manager install -y openssl-devel
$manager install -y zlib-devel
$manager install -y readline-devel
$manager install -y libyaml-devel
$manager install -y libffi-devel

if ! [ -e /usr/local/rbenv/bin/rbenv ]; then
  cd /usr/local
  git clone https://github.com/sstephenson/rbenv.git
  mkdir /usr/local/rbenv/plugins
  cd /usr/local/rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git
fi

if ! cat /etc/group | awk -F : '{print $1}' | egrep ^rbenv$; then
  groupadd rbenv
fi
gpasswd -a $user rbenv
chown -R $user:rbenv /usr/local/rbenv

cat << "__EOS__" > /etc/profile.d/rbenv.sh
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
__EOS__

# direnv
if ! type direnv >/dev/null 2>&1; then
  cd /tmp
  git clone https://github.com/direnv/direnv.git
  cd direnv
  make install
fi

# markdown viewer
pip install grip

# sshd
systemctl enable sshd.service
systemctl start  sshd.service

# firewalld

# SELinux
sed -i -e 's/^SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config

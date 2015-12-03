#!/bin/bash
set -eux

# only root privilege
if [ $(whoami) != root ];then
  exit
fi

# for fedora-21
# basic
yum install -y yum-fastestmirror
yum install -y vim
yum install -y git
yum install -y tig
yum install -y tmux
yum install -y gcc-c++
yum install -y automake
yum install -y autoconf
yum install -y strace
yum install -y man-pages-ja

# code reading
yum install -y patch
yum install -y ccache
yum install -y ncurses-devel
yum install -y ctags

# web+db
yum install -y nginx
yum install -y mariadb
yum install -y mariadb-server
yum install -y mariadb-devel

# ruby
yum install -y openssl-devel
yum install -y zlib-devel
yum install -y readline-devel
yum install -y libyaml-devel
yum install -y libffi-devel

if ! [ -e /usr/local/rbenv/bin/rbenv ]; then
  cat /etc/group | awk -F : '{print $1}' | egrep ^rbenv$
  if [ $? != 0 ]; then
    groupadd rbenv
  fi
  gpasswd -a vagrant rbenv

  cd /usr/local
  git clone https://github.com/sstephenson/rbenv.git

  chown -R vagrant:rbenv /usr/local/rbenv

  mkdir /usr/local/rbenv/plugins
  cd /usr/local/rbenv/plugins
  git clone https://github.com/sstephenson/ruby-build.git
fi

cat << "__EOS__" > /etc/profile.d/rbenv.sh
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
__EOS__

## sshd
systemctl enable sshd.service
systemctl start  sshd.service

## SELinux
sed -i -e 's/^SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config

#!/bin/bash
set -ux

# only root privilege
if [ $(whoami) != root ]; then
  exit
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
$manager install -y man-pages-ja
$manager install -y the_silver_searcher
$manager install -y parallel
$manager install -y lftp
$manager install -y clang
$manager install -y strace
$manager install -y ltrace
# https://sourceware.org/systemtap/examples/
$manager install -y systemtap
$manager install -y python2-editorconfig
$manager install -y dstat
$manager install -y iotop
# $manager install -y python3-editorconfig

# filesystem
$manager install -y fuse-sshfs
$manager install -y fuse-devel
$manager install -y autofs
$manager install -y bindfs
$manager install -y inotify-tools
$manager install -y ddrescue

# cgroup
$manager install -y libcgroup-tools

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
$manager install -y jq

# AMQP
$manager install -y rabbitmq-server

# Utility
$manager install -y s3cmd

# Healing
$manager install -y sl
$manager install -y banner
$manager install -y cowsay

# KVM
# $manager -y install -y qemu-kvm
# $manager -y install -y qemu-kvm-tools


# Ruby Requirements
$manager install -y openssl-devel
$manager install -y zlib-devel
$manager install -y readline-devel
$manager install -y libyaml-devel
$manager install -y libffi-devel

source ./provisioners/shared/as_root.sh
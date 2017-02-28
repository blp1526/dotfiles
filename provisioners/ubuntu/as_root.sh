#!/bin/bash
set -ux

# only root privilege
if [ $(whoami) != root ]; then
  exit
fi

# apt update -y
# apt upgrade -y

# Basic
apt install -y git
apt install -y tig
apt install -y tmux
apt install -y vim
apt install -y ctags
apt install -y clang
apt install -y silversearcher-ag
apt install -y golang
apt install -y dstat

# Healing
apt install -y sl
apt install -y sysvbanner
apt install -y cowsay

# Web+DB
apt install -y nginx
apt install -y jq

# Network
apt install -y ssh

# Kernel
apt install -y libncurses-dev
apt install -y build-essential
apt install -y fakeroot
apt install -y kernel-package
apt install -y linux-source

# Ruby https://github.com/rbenv/ruby-build/wiki
apt install -y autoconf
apt install -y bison
apt install -y libssl-dev
apt install -y libyaml-dev
apt install -y libreadline6-dev
apt install -y zlib1g-dev
apt intalll -y libncurses5-dev
apt install -y libffi-dev
apt install -y libgdbm3
apt install -y libgdbm-dev

source ./provisioners/shared/as_root.sh

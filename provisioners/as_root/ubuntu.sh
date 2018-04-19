#!/bin/bash
set -ux

# XXX: image and checksum
# http://releases.ubuntu.com/

grep "DISTRIB_ID=Ubuntu" /etc/lsb-release >/dev/null 2>&1
if [ "$?" -ne "0" ]; then
  echo "Unexpected OS"
  exit 1
fi

# only root privilege
if [ $(whoami) != "root" ]; then
  echo "Use sudo"
  exit 1
fi

apt update -y
apt upgrade -y

apt install -y apt-file
apt-file update

# Basic
apt install -y gdisk
apt install -y git
apt install -y tmux
apt install -y ctags
apt install -y clang
apt install -y silversearcher-ag
apt install -y dstat
apt install -y iotop
apt install -y tree
apt install -y lftp
apt install -y docker.io
apt install -y python-pip
apt install -y multipath-tools
apt install -y imagemagick
apt install -y libncursesw5-dev
# see the latest golang installation guide via https://github.com/golang/go/wiki/Ubuntu

# Healing
apt install -y sl
apt install -y sysvbanner
apt install -y cowsay

# snap
apt install -y snapd
apt install -y snapcraft

# Web+DB
apt install -y curl
apt install -y nginx
apt install -y jq

# Network
apt install -y ssh
apt install -y libnss-myhostname
apt install -y nmap
# l2tp via https://github.com/nm-l2tp/network-manager-l2tp/wiki/Prebuilt-Packages#ubuntu-and-mint

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

# Python https://github.com/pyenv/pyenv/wiki
apt install -y make
apt install -y build-essential
apt install -y libssl-dev
apt install -y zlib1g-dev
apt install -y libbz2-dev
apt install -y libreadline-dev
apt install -y libsqlite3-dev
apt install -y wget
apt install -y curl
apt install -y llvm
apt install -y libncurses5-dev
apt install -y xz-utils
apt install -y tk-dev

lscpu | grep vmx >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt install -y qemu-kvm
  apt install -y libvirt0
  apt install -y libvirt-bin
  apt install -y virt-manager
  apt install -y bridge-utils
  apt install -y libguestfs-tools
fi

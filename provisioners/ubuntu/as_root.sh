#!/bin/bash
set -ux

# XXX: image and checksum
# http://releases.ubuntu.com/

# only root privilege
if [ $(whoami) != "root" ]; then
  exit
fi

# https://github.com/golang/go/wiki/Ubuntu
source /etc/lsb-release
if [ "${DISTRIB_RELEASE}" = "16.04" ]; then
  add-apt-repository ppa:longsleep/golang-backports
fi

apt update -y
apt upgrade -y

apt install -y apt-file
apt-file update

# Basic
apt install -y git
apt install -y tig
apt install -y tmux
# enable lua flag
apt install -y vim-gnome
apt install -y ctags
apt install -y clang
apt install -y silversearcher-ag
apt install -y golang-go
apt install -y dstat
apt install -y iotop
apt install -y tree
apt install -y lftp
apt install -y docker.io
apt install -y python-pip

# Healing
apt install -y sl
apt install -y sysvbanner
apt install -y cowsay

# Web+DB
apt install -y nginx
apt install -y jq

# Network
apt install -y ssh
apt install -y libnss-myhostname

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

lscpu | grep vmx >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt install -y qemu-kvm
  apt install -y libvirt0
  apt install -y libvirt-bin
  apt install -y virt-manager
  apt install -y bridge-utils
fi

dpkg -l ubuntu-desktop >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt install -y guake
  # Keyboard and Mouse => Keytheme => Emacs
  apt install -y gnome-tweak-tool
fi

source ./provisioners/shared/as_root.sh

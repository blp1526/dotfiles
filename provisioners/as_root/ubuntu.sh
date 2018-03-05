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
apt install -y gdisk
apt install -y git
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
apt install -y multipath-tools
apt install -y imagemagick

# Healing
apt install -y sl
apt install -y sysvbanner
apt install -y cowsay

# Web+DB
apt install -y nginx
apt install -y jq

# ElasticSearch
apt install -y openjdk-8-jdk
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt install -y apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
apt update -y
apt install -y elasticsearch

# Network
apt install -y ssh
apt install -y libnss-myhostname
apt install -y strongswan
apt install -y xl2tpd
apt install -y ike-scan
apt install -y nmap

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

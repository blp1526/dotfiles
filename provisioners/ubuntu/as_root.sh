#!/bin/bash
set -ux

apt update
apt upgrade

# Basic
apt install git
apt install tig
apt install tmux
apt install vim
apt install ctags
apt install clang
apt install silversearcher-ag
apt install golang # to install peco

# Network
apt install ssh
systemctl enable ssh.service
systemctl start  ssh.service

# Kernel
apt install libncurses-dev
apt install build-essential
apt install fakeroot
apt install kernel-package
apt install linux-source

# Ruby
apt install autoconf
apt install bison
apt install libssl-dev
apt install libyaml-dev
apt install libreadline6-dev
apt install zlib1g-dev
apt intalll libncurses5-dev
apt install libffi-dev
apt install libgdbm3
apt install libgdbm-dev

source ./provisioners/shared/as_root.sh

#!/bin/bash
set -ux

apt update
apt upgrade

# basic
apt install git
apt install tig
apt install tmux
apt install vim
apt install ctags
apt install clang
apt install silversearcher-ag
apt install golang # to install peco

# network
apt install ssh
systemctl enable ssh.service
systemctl start  ssh.service

# kernel
apt install libncurses-dev
apt install build-essential
apt install fakeroot
apt install kernel-package
apt install linux-source

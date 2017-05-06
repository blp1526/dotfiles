#!/usr/bin/env bash

# https://wiki.archlinuxjp.org/index.php/%E6%99%82%E5%88%BB
timedatectl set-timezone Asia/Tokyo

pacman --needed -S openssh

# https://github.com/rbenv/ruby-build/wiki
pacman --needed -S openssl
pacman --needed -S libyaml
pacman --needed -S libffi
pacman --needed -S zlib

pacman --needed -S bash-completion
pacman --needed -S gptfdisk
pacman --needed -S hdparm
pacman --needed -S mlocate
pacman --needed -S tmux
pacman --needed -S git
pacman --needed -S tig
pacman --needed -S the_silver_searcher
pacman --needed -S strace
pacman --needed -S unzip
pacman --needed -S go
pacman --needed -S python
pacman --needed -S python-pip
pacman --needed -S python-editorconfig
pacman --needed -S vim
pacman --needed -S tree
pacman --needed -S lftp
pacman --needed -S ctags
pacman --needed -S docker

# https://wiki.archlinuxjp.org/index.php/Docker
actual=$(lsmod | grep loop | awk '{print $1 }')
expected='loop'
if [ $actual != $expected ]; then
  tee /etc/modules-load.d/loop.conf <<< "loop"
  modprobe loop
fi

updatedb

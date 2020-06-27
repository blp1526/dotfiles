#!/bin/bash
set -eux

if [ "$(whoami)" != "root" ]; then
  echo "Use sudo"
  exit 1
fi

grep 'PRETTY_NAME="Ubuntu 20.04 LTS"' /etc/os-release >/dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "Unexpected OS"
  exit 1
fi

apt-get update -y
apt-get upgrade -y

# Basic
apt-get install -y build-essential
apt-get install -y debian-goodies
apt-get install -y debconf-utils
apt-get install -y gdisk
apt-get install -y git
apt-get install -y git-extras
apt-get install -y vim
apt-get install -y fish
apt-get install -y neovim
apt-get install -y tig
apt-get install -y ansible
apt-get install -y tmux
apt-get install -y clang
apt-get install -y silversearcher-ag
apt-get install -y dstat
apt-get install -y iotop
apt-get install -y fio
apt-get install -y cpulimit
apt-get install -y bat
apt-get install -y tree
apt-get install -y pwgen
apt-get install -y lftp
apt-get install -y multipath-tools
apt-get install -y pandoc
apt-get install -y hwinfo
apt-get install -y libncursesw5-dev
apt-get install -y systemd-container
apt-get install -y debootstrap
apt-get install -y gdebi
apt-get install -y btrfs-progs
apt-get install -y bindfs
apt-get install -y sshfs
apt-get install -y gocryptfs
apt-get install -y inotify-tools
apt-get install -y cloud-guest-utils
apt-get install -y cloud-image-utils
apt-get install -y testdisk
apt-get install -y ncdu
apt-get install -y tldr
apt-get install -y curl
apt-get install -y httpie
apt-get install -y wget
apt-get install -y parallel
apt-get install -y gnupg2
apt-get install -y pass
apt-get install -y cockpit
apt-get install -y sysstat
sed -e 's/^ENABLED="false"$/ENABLED="true"/g' -i /etc/default/sysstat
apt-get install -y crash
apt-get install -y ccze
apt-get install -y shellcheck
apt-get install -y jq
apt-get install -y peco
apt-get install -y direnv
apt-get install -y neofetch
apt-get install -y elfutils
apt-get install -y clang-format
apt-get install -y liblz4-tool
apt-get install -y binwalk
apt-get install -y exiftool
apt-get install -y uuid-dev
apt-get install -y libpopt-dev
apt-get install -y libelf-dev
apt-get install -y libseccomp-dev
apt-get install -y uidmap
apt-get install -y oprofile
apt-get install -y linux-tools-common
apt-get install -y "linux-tools-$(uname -r)"

# Network
apt-get install -y libnss-myhostname
apt-get install -y traceroute
apt-get install -y whois
apt-get install -y autossh
apt-get install -y sshpass
apt-get install -y proxychains4
apt-get install -y tsocks
apt-get install -y conntrack

# Security
apt-get install -y nmap

# Kernel
apt-get install -y libncurses-dev
apt-get install -y fakeroot
apt-get install -y kernel-package
apt-get install -y linux-source
apt-get install -y sysfsutils
apt-get install -y cgroup-tools

# Ruby https://github.com/rbenv/ruby-build/wiki
apt-get install -y autoconf
apt-get install -y bison
apt-get install -y libssl-dev
apt-get install -y libyaml-dev
apt-get install -y libreadline6-dev
apt-get install -y zlib1g-dev
apt-get install -y libncurses5-dev
apt-get install -y libffi-dev
apt-get install -y libgdbm6
apt-get install -y libgdbm-dev

# Python https://github.com/pyenv/pyenv/wiki
apt-get install -y libssl-dev
apt-get install -y zlib1g-dev
apt-get install -y libbz2-dev
apt-get install -y libreadline-dev
apt-get install -y libsqlite3-dev
apt-get install -y llvm
apt-get install -y libncurses5-dev
apt-get install -y xz-utils
apt-get install -y tk-dev
apt-get install -y libxml2-dev
apt-get install -y libxmlsec1-dev
apt-get install -y libffi-dev
apt-get install -y liblzma-dev

# PHP
apt-get install -y libxml2-dev
apt-get install -y libkrb5-dev
apt-get install -y libssl-dev
apt-get install -y libsqlite3-dev
apt-get install -y libbz2-dev
apt-get install -y libpng-dev
apt-get install -y libjpeg-dev
apt-get install -y libonig-dev
apt-get install -y libreadline-dev
apt-get install -y libtidy-dev
apt-get install -y libxslt-dev
apt-get install -y libcurl4-openssl-dev
apt-get install -y libzip-dev

# KVM
lscpu | grep vmx >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt-get install -y qemu-kvm
  apt-get install -y libvirt0
  apt-get install -y libosinfo-bin
  apt-get install -y libvirt-dev
  apt-get install -y virt-manager
  apt-get install -y virt-top
  apt-get install -y virt-sandbox
  apt-get install -y virt-what
  apt-get install -y bridge-utils
  apt-get install -y libguestfs-tools
  apt-get install -y ovmf
  apt-get install -y qemu-user-static
fi

# Desktop
dpkg -l ubuntu-desktop >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt-get install -y gnome-tweak-tool
  apt-get install -y ibus-mozc
  apt-get install -y dconf-editor
  apt-get install -y xsel
  apt-get install -y network-manager-l2tp-gnome
  apt-get install -y keepassxc
  apt-get install -y wireshark

  snap install code --classic
  snap install atom --classic
fi

lscpu | grep -i vmware >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt-get install -y open-vm-tools
  apt-get install -y open-vm-tools-desktop
  # http://libguestfs.org/guestfs.3.html#force_tcg via https://bugzilla.redhat.com/show_bug.cgi?id=1648403
  cat /etc/environment | grep -E '^LIBGUESTFS_BACKEND_SETTINGS="force_tcg"' >/dev/null 2>&1
  if [ ${?} -eq 1 ]; then
    echo 'LIBGUESTFS_BACKEND_SETTINGS="force_tcg"' >> /etc/environment
  fi
fi

apt-get install -y apt-file
apt-file update

#!/bin/bash
set -eux

if [ "$(whoami)" != "root" ]; then
  echo "Use sudo"
  exit 1
fi

grep "ID=ubuntu" /etc/os-release >/dev/null 2>&1
if [ "$?" != "0" ]; then
  echo "Unexpected OS"
  exit 1
fi

apt update -y
apt upgrade -y

apt install -y apt-file
apt-file update

# Basic
apt install -y build-essential
apt install -y debian-goodies
apt install -y gdisk
apt install -y git
apt install -y vim-gnome
apt install -y neovim
apt install -y tig
apt install -y tmux
apt install -y clang
apt install -y silversearcher-ag
apt install -y dstat
apt install -y iotop
apt install -y tree
apt install -y lftp
apt install -y multipath-tools
apt install -y pandoc
apt install -y hwinfo
apt install -y libncursesw5-dev
apt install -y systemd-container
apt install -y debootstrap
apt install -y gdebi
apt install -y btrfs-progs
apt install -y zfsutils-linux
apt install -y bindfs
apt install -y sshfs
apt install -y cloud-guest-utils
apt install -y testdisk
apt install -y curl
apt install -y wget
apt install -y sysstat
apt install -y crash
apt install -y ccze
apt install -y shellcheck
apt install -y jq
apt install -y peco
apt install -y direnv
apt install -y neofetch
apt install -y elfutils
apt install -y clang-format
apt install -y liblz4-tool
apt install -y binwalk
apt install -y exiftool
apt install -y uuid-dev
apt install -y libpopt-dev
apt install -y libelf-dev
apt install -y libseccomp-dev
apt install -y uidmap
apt install -y linux-tools-common
apt install -y "linux-tools-$(uname -r)"

# Network
apt install -y libnss-myhostname
apt install -y traceroute
apt install -y whois
apt install -y autossh

# Security
apt install -y nmap

# Kernel
apt install -y libncurses-dev
apt install -y fakeroot
apt install -y kernel-package
apt install -y linux-source
apt install -y sysfsutils
apt install -y cgroup-tools

# Ruby https://github.com/rbenv/ruby-build/wiki
apt install -y autoconf
apt install -y bison
apt install -y libssl-dev
apt install -y libyaml-dev
apt install -y libreadline6-dev
apt install -y zlib1g-dev
apt install -y libncurses5-dev
apt install -y libffi-dev
apt install -y libgdbm5
apt install -y libgdbm-dev

# Python https://github.com/pyenv/pyenv/wiki
apt install -y libssl-dev
apt install -y zlib1g-dev
apt install -y libbz2-dev
apt install -y libreadline-dev
apt install -y libsqlite3-dev
apt install -y llvm
apt install -y libncurses5-dev
apt install -y xz-utils
apt install -y tk-dev
apt install -y libxml2-dev
apt install -y libxmlsec1-dev
apt install -y libffi-dev
apt install -y liblzma-dev

# KVM
lscpu | grep vmx >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt install -y qemu-kvm
  apt install -y libvirt0
  apt install -y libvirt-bin
  apt install -y libvirt-dev
  apt install -y virt-manager
  apt install -y virt-top
  apt install -y virt-sandbox
  apt install -y virt-what
  apt install -y bridge-utils
  apt install -y libguestfs-tools
  apt install -y ovmf
  apt install -y qemu-user-static
fi

# Desktop
dpkg -l ubuntu-desktop >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt install -y gnome-tweak-tool
  apt install -y dconf-editor
fi

lscpu | grep -i vmware >/dev/null 2>&1
if [ ${?} -eq 0 ]; then
  apt install -y open-vm-tools
  # http://libguestfs.org/guestfs.3.html#force_tcg via https://bugzilla.redhat.com/show_bug.cgi?id=1648403
  cat /etc/environment | grep -E '^LIBGUESTFS_BACKEND_SETTINGS="force_tcg"' >/dev/null 2>&1
  if [ ${?} -eq 1 ]; then
    echo 'LIBGUESTFS_BACKEND_SETTINGS="force_tcg"' >> /etc/environment
  fi
fi

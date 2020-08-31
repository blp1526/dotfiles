#!/usr/bin/env bash
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

apt-get update -y
apt-get upgrade -y
apt-get install -y xrdp

sed -e 's/^new_cursors=true$/new_cursors=false/g' -i /etc/xrdp/xrdp.ini
sed -e 's/^FuseMountName=thinclient_drives$/FuseMountName=\.thinclient_drives/g' -i /etc/xrdp/sesman.ini
cat << __EOS__ > /etc/polkit-1/localauthority/50-local.d/xrdp-color-manager.pkla
[NetworkManager]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device
ResultAny=no
ResultInactive=no
ResultActive=yes
__EOS__

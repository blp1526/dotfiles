#!/bin/bash
set -eux

if [ "$(whoami)" != "root" ]; then
  echo "Use sudo"
  exit 1
fi

grep "ID=ubuntu" /etc/os-release >/dev/null 2>&1
if [ "$?" -ne "0" ]; then
  echo "Unexpected OS"
  exit 1
fi

# Docker https://docs.docker.com/install/linux/docker-ce/ubuntu
apt install -y apt-transport-https
apt install -y ca-certificates
apt install -y curl
apt install -y gnupg-agent
apt install -y software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update -y

apt install -y docker-ce
apt install -y docker-ce-cli
apt install -y containerd.io
apt install -y docker-compose

# user="user"
# cat /etc/group | grep ^"docker": | grep :"${user}"$ >/dev/null 2>&1
# if ! [ ${?} -eq 0 ]; then
#   # https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user
#   gpasswd -a "${user}" docker
# fi

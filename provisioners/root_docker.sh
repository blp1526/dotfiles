#!/usr/bin/env bash -eux

if [ "$(whoami)" != "root" ]; then
  echo "Use sudo"
  exit 1
fi

grep "ID=ubuntu" /etc/os-release >/dev/null 2>&1
if [ "$?" -ne "0" ]; then
  echo "Unexpected OS"
  exit 1
fi

code_name=$(lsb_release -cs)
echo "If you don't want docker for ${code_name}, enter specific code name."
read -r expected_code_name

if [ "${expected_code_name}" != "" ]; then
  code_name="${expected_code_name}"
fi

# docker-ce https://docs.docker.com/install/linux/docker-ce/ubuntu
apt-get install -y apt-transport-https
apt-get install -y ca-certificates
apt-get install -y curl
apt-get install -y gnupg-agent
apt-get install -y software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${code_name} stable"
apt-get update -y

apt-get install -y docker-ce
apt-get install -y docker-ce-cli
apt-get install -y containerd.io
apt-get install -y docker-compose

# postinstall https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user

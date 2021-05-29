#!/usr/bin/env bash
# https://docs.docker.com/engine/install/ubuntu/
set -eux

sudo apt-get update -y

sudo apt-get install -y apt-transport-https
sudo apt-get install -y ca-certificates
sudo apt-get install -y curl
sudo apt-get install -y gnupg
sudo apt-get install -y lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

target="amd64"
if [ "$(arch)" == "aarch64" ]; then
  target="arm64"
fi

echo \
  "deb [arch=${target} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

sudo apt-get install -y docker-ce
sudo apt-get install -y docker-ce-cli
sudo apt-get install -y containerd.io

echo "Read https://docs.docker.com/engine/install/linux-postinstall/"

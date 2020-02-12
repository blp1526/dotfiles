#!/bin/bash
set -eux

export DOCKER_HOST="unix:///${XDG_RUNTIME_DIR}/docker.sock"

if ! [ -e ~/bin/dockerd ]; then
  curl -fsSL https://get.docker.com/rootless | sh
fi

if ! [ -e ~/bin/docker-compose ]; then
  cd ~/bin
  latest=$(curl https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
  curl -LO "https://github.com/docker/compose/releases/download/${latest}/docker-compose-Linux-x86_64"
  mv docker-compose-Linux-x86_64 docker-compose
  chmod 755 docker-compose
fi

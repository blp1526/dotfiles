#!/usr/bin/env bash -eux

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

if ! [ -e ~/bin/hadolint ]; then
  cd ~/bin
  latest=$(curl https://api.github.com/repos/hadolint/hadolint/releases/latest | jq -r .tag_name)
  curl -LO "https://github.com/hadolint/hadolint/releases/download/${latest}/hadolint-Linux-x86_64"
  mv hadolint-Linux-x86_64 hadolint
  chmod 755 hadolint
fi

# https://docs.docker.com/engine/security/rootless/
# systemctl --user start docker

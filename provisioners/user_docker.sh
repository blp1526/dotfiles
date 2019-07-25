#!/bin/bash
set -ux

if ! [ -e ~/bin/docker ]; then
  curl -fsSL https://get.docker.com/rootless | sh
fi

if ! [ -e ~/bin/docker-compose ]; then
  cd ~/bin
  curl -LO https://github.com/docker/compose/releases/download/1.24.1/docker-compose-Linux-x86_64
  mv docker-compose-Linux-x86_64 docker-compose
  chmod 755 docker-compose
fi

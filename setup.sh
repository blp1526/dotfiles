#!/usr/bin/env bash
set -eux -o pipefail

stow --dir=stow --target="${HOME}" --verbose root bin gnupg config

npm install -g @devcontainers/cli

#!/usr/bin/env bash
set -eux -o pipefail

mkdir -p ~/.config/git
mkdir -p ~/.config/nvim
mkdir -p ~/.config/lazygit
stow --dir=stow --target="${HOME}" --verbose root config

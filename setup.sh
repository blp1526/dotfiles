#!/usr/bin/env bash
set -eux -o pipefail

mkdir -p ~/.config/git
mkdir -p ~/.config/lazygit
mkdir -p ~/.config/ghostty
stow --dir=stow --target="${HOME}" --verbose root config

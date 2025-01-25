#!/usr/bin/env bash
set -eux -o pipefail

mkdir -p ~/bin
mkdir -p ~/.gnupg
mkdir -p ~/.config/git
mkdir -p ~/.config/nvim
stow --dir=stow --target="${HOME}" --verbose root bin gnupg config

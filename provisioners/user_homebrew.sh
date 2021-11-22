#!/usr/bin/env bash
set -eux

brew install bash
brew install bash-completion
brew install git
brew install git-extras
brew install git-lfs
brew install gh
brew install vim
brew install peco
brew install ghq
brew install tig
brew install tmux
brew install the_silver_searcher
brew install jq
brew install yq
brew install neofetch
brew install onefetch
brew install wget
brew install tree
brew install lftp
brew install rclone
brew install ansible
brew install gnupg2
brew install pinentry-mac
brew install gopass
brew install httpie
brew install shellcheck
brew install bat
brew install ccze
brew install mysql-client
brew install coreutils
brew install util-linux
brew install direnv
brew install iproute2mac
brew install qemu
brew install lima
brew install vagrant
brew install minikube
brew install docker
brew install lazydocker
brew install htop
brew install ffmpeg
brew install lz4

# https://github.com/rbenv/ruby-build/wiki
# https://github.com/pyenv/pyenv/wiki
brew install openssl
brew install readline
brew install sqlite3
brew install xz
brew install zlib

if type docker >/dev/null 2>&1; then
  # https://docs.docker.com/docker-for-mac/#install-shell-completion
  etc=/Applications/Docker.app/Contents/Resources/etc
  ln -sf "${etc}/docker.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker"
  ln -sf "${etc}/docker-compose.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-compose"
fi

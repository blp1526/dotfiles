#!/bin/bash
set -x

if [ $(uname) = Darwin ]; then
  # Install manually below list not by homebrew cask
  # Google Chrome
  # Firefox
  # Google Japanese Input
  # iTerm2
  # VirtualBox
  # Vagrant
  # Alfred 2
  # Atom
  # Java
  # JMeter
  # OWASP ZAP
  # Dash
  # Evernote
  # Skitch
  # Karabiner
  # Shiftit
  # Slack
  # PopHub
  # The Unarchiver
  # WireShark
  # Kindle
  # Security Soft

  if ! type brew >/dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew install git
  brew install gibo
  brew install tig
  brew install vim
  brew install wget
  brew install tree
  brew install readline
  brew install openssl
  brew install nmap
  brew install ctags
  brew install bash-completion
  brew install tmux
  brew install mobile-shell
  brew install direnv
  brew install the_silver_searcher
  brew install go
  brew install rbenv
  brew install ruby-build
  brew install reattach-to-user-namespace

  if ! [ -e ${HOME}/bin ]; then
    mkdir ${HOME}/bin
  fi

  if ! type pecrant >/dev/null 2>&1; then
    curl -o ${HOME}/bin/pecrant https://raw.githubusercontent.com/gongo/pecrant/master/pecrant
    chmod +x ${HOME}/bin/pecrant
  fi
fi

cd $(dirname $0)

ln -sf $(pwd)/.bash_profile ~/
ln -sf $(pwd)/.bashrc       ~/
ln -sf $(pwd)/.gitconfig    ~/
ln -sf $(pwd)/.vimrc        ~/
ln -sf $(pwd)/.tmux.conf    ~/
ln -sf $(pwd)/.tigrc        ~/
ln -sf $(pwd)/.gemrc        ~/
ln -sf $(pwd)/.inputrc      ~/
ln -sf $(pwd)/.rubocop.yml  ~/

if ! [ -e ~/.gitconfig.local ]; then
  echo 'Enter name for .gitconfig.local'
  read name
  echo 'Enter email for .gitconfig.local'
  read email

cat << __EOS__ > ~/.gitconfig.local
[user]
  name  = "${name}"
  email = "${email}"
__EOS__
fi

. ~/.bash_profile

if ! [ -e ${HOME}/.vim/bundle ]; then
  curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
fi

if ! type nodebrew >/dev/null 2>&1; then
  curl -L git.io/nodebrew | perl - setup
fi

if ! type peco >/dev/null 2>&1; then
  go get github.com/peco/peco/cmd/peco
fi

if ! type ghq >/dev/null 2>&1; then
  go get github.com/motemen/ghq
fi

if ! type bats >/dev/null 2>&1; then
  git clone https://github.com/sstephenson/bats.git ~/.bats
fi

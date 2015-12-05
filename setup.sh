#!/bin/bash -ex
cd $(dirname $0)

ln -sf $(pwd)/.bash_profile    ~/
ln -sf $(pwd)/.bashrc          ~/
ln -sf $(pwd)/.gitconfig       ~/
ln -sf $(pwd)/.gitconfig.local ~/
ln -sf $(pwd)/.vimrc           ~/
ln -sf $(pwd)/.tmux.conf       ~/
ln -sf $(pwd)/.tigrc           ~/
ln -sf $(pwd)/.gemrc           ~/
ln -sf $(pwd)/.inputrc         ~/
ln -sf $(pwd)/.rubocop.yml     ~/

if [ -e  $(pwd)/.ssh ]; then
  ln -sf $(pwd)/.ssh           ~/
fi

if ! [ -e ${HOME}/.vim/bundle ]; then
  curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
fi

# node.js
which nodebrew
if [ $? != 0 ]; then
  curl -L git.io/nodebrew | perl - setup
fi

# golang
which ghq
if [ $? != 0 ]; then
  go get github.com/motemen/ghq
fi

which peco
if [ $? != 0 ]; then
  go get github.com/peco/peco/cmd/peco
fi


if [ $(uname) = Darwin ]; then
  which brew
  if [ $? != 0 ]; then
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
fi

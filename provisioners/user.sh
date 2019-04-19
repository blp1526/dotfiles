#!/bin/bash

cd $(dirname $0)
dotfiles_path=${HOME}/src/github.com/blp1526/dotfiles

mkdir -p ${HOME}/bin
mkdir -p ${HOME}/src
mkdir -p ${HOME}/.config/git
mkdir -p ${HOME}/.config/peco
ln -sf ${dotfiles_path}/.config/peco/config.json ~/.config/peco/config.json
ln -sf ${dotfiles_path}/bin/git-gopath ~/bin/git-gopath

file_names=(
  .bash_profile
  .bashrc
  .gitconfig
  .vimrc
  .tmux.conf
  .tigrc
  .gemrc
  .inputrc
  .rubocop.yml
  .lftprc
  .ctags
)

for file_name in "${file_names[@]}"; do
  ln -sf ${dotfiles_path}/${file_name} ~/
done

if ! type anyenv >/dev/null 2>&1; then
  git clone https://github.com/anyenv/anyenv ~/.anyenv
fi

if ! type rustc >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh
fi

if ! type direnv >/dev/null 2>&1; then
  # https://github.com/direnv/direnv#install
  git gopath 'https://github.com/direnv/direnv.git'
fi

if ! type gibo >/dev/null 2>&1; then
  # https://github.com/simonwhitaker/gibo#installation
  git gopath 'https://github.com/simonwhitaker/gibo.git'
fi

if ! type peco >/dev/null 2>&1; then
  # https://github.com/peco/peco#building-peco-yourself
  git gopath 'https://github.com/peco/peco.git'
fi

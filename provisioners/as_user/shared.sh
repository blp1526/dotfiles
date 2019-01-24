#!/bin/bash

cd $(dirname $0)

if ! [ -e ${HOME}/bin ]; then
  mkdir ${HOME}/bin
fi

if ! [ -e ${HOME}/src ]; then
  mkdir ${HOME}/src
fi

if ! [ -e ${HOME}/pkg ]; then
  mkdir ${HOME}/pkg
fi

if ! [ -e ${HOME}/.config/peco ]; then
  mkdir -p ${HOME}/.config/peco
fi

if ! [ -e ${HOME}/.config/git ]; then
  mkdir -p ${HOME}/.config/git
fi
dotfiles_path=${HOME}/src/github.com/blp1526/dotfiles

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

config_file_path=(
  peco/config.json
  git/ignore
)

for config_file_path in "${config_file_path[@]}"; do
  ln -sf ${dotfiles_path}/.config/${config_file_path} ~/.config/${config_file_path}
done

ln -sf ${dotfiles_path}/bin/trackpadable ~/bin/trackpadable
ln -sf ${dotfiles_path}/bin/git-gopath   ~/bin/git-gopath

. ~/.bash_profile >/dev/null 2>&1

if ! type nodebrew >/dev/null 2>&1; then
  curl -L git.io/nodebrew | perl - setup
fi

if ! type rustc >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh
fi

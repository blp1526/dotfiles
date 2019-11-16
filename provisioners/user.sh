#!/bin/bash

mkdir -p ${HOME}/bin
mkdir -p ${HOME}/src

dotfiles_path=${HOME}/src/github.com/blp1526/dotfiles

mkdir -p ${HOME}/.config/nvim
ln -sf ${dotfiles_path}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim

mkdir -p ${HOME}/.config/peco
ln -sf ${dotfiles_path}/.config/peco/config.json ${HOME}/.config/peco/config.json

mkdir -p ${HOME}/.config/git
if ! [ -e ${HOME}/.config/git/ignore ]; then
  cp ${dotfiles_path}/.config/git/ignore ${HOME}/.config/git/ignore
fi

file_names=(
  .bashrc
  .gitconfig
  .vimrc
  .tmux.conf
  .tigrc
  .inputrc
  .lftprc
)

for file_name in "${file_names[@]}"; do
  ln -sf ${dotfiles_path}/${file_name} ${HOME}/${file_name}
done

if ! type anyenv >/dev/null 2>&1; then
  git clone https://github.com/anyenv/anyenv ${HOME}/.anyenv
fi

if ! type rustc >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh
fi

if ! type gibo >/dev/null 2>&1; then
  # https://github.com/simonwhitaker/gibo#installation
  git clone https://github.com/simonwhitaker/gibo.git ${HOME}/src/github.com/simonwhitaker/gibo
fi

if ! [ -e ${HOME}/src/github.com/Bash-it/bash-it ]; then
  git clone https://github.com/Bash-it/bash-it.git ${HOME}/src/github.com/Bash-it/bash-it
fi

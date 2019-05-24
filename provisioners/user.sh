#!/bin/bash

mkdir -p ${HOME}/bin
mkdir -p ${HOME}/src
mkdir -p ${HOME}/.config/git
mkdir -p ${HOME}/.config/peco

dotfiles_path=${HOME}/src/github.com/blp1526/dotfiles
ln -sf ${dotfiles_path}/.config/peco/config.json ${HOME}/.config/peco/config.json

file_names=(
  .bash_profile
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

if ! type direnv >/dev/null 2>&1; then
  # https://github.com/direnv/direnv#install
  git clone https://github.com/direnv/direnv.git ${HOME}/src/github.com/direnv/direnv
fi

if ! type gibo >/dev/null 2>&1; then
  # https://github.com/simonwhitaker/gibo#installation
  git clone https://github.com/simonwhitaker/gibo.git ${HOME}/src/github.com/simonwhitaker/gibo
fi

if ! type peco >/dev/null 2>&1; then
  # https://github.com/peco/peco#building-peco-yourself
  git clone https://github.com/peco/peco.git ${HOME}/src/github.com/peco/peco
fi

if ! type gopls >/dev/null 2>&1; then
  # https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Go
  go get -u golang.org/x/tools/cmd/gopls
fi

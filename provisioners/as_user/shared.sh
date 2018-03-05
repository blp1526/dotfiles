#!/bin/bash

cd $(dirname $0)

tempdir=$(mktemp -d)

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

dotfiles_path=${HOME}/src/github.com/blp1526/dotfiles

file_names=(
  .bash_profile
  .bashrc
  .gitconfig
  .vimrc
  .tmux.conf
  .tigrc
  .gemrc
  .railsrc
  .inputrc
  .proverc
  .rubocop.yml
  .lftprc
  .ctags
  .npm-completion.sh
  .gitignore_global
)

for file_name in "${file_names[@]}"; do
  ln -sf ${dotfiles_path}/${file_name} ~/
done

config_file_path=(
  peco/config.json
)

for config_file_path in "${config_file_path[@]}"; do
  ln -sf ${dotfiles_path}/.config/${config_file_path} ~/.config/${config_file_path}
done

ln -sf ${dotfiles_path}/bin/trackpadable ~/bin/trackpadable
ln -sf ${dotfiles_path}/bin/git-clone-to-gopath ~/bin/git-clone-to-gopath

. ~/.bash_profile >/dev/null 2>&1

if ! type nodebrew >/dev/null 2>&1; then
  curl -L git.io/nodebrew | perl - setup
fi

if ! type peco >/dev/null 2>&1; then
  curl -L https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz -o ${tempdir}/peco.tar.gz
  tar zxvf ${tempdir}/peco.tar.gz -C ${tempdir}
  mv ${tempdir}/peco_linux_amd64/peco ~/bin
fi

if ! type rustc >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh
fi

rm -rf ${tempdir}

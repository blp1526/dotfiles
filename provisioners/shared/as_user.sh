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

if ! [ -e ${HOME}/tmp ]; then
  mkdir ${HOME}/tmp
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
  .editorconfig
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

. ~/.bash_profile >/dev/null 2>&1

if ! type nodebrew >/dev/null 2>&1; then
  curl -L git.io/nodebrew | perl - setup
fi

if ! type bats >/dev/null 2>&1; then
  git clone https://github.com/sstephenson/bats.git ~/.bats
fi

if ! type peco >/dev/null 2>&1; then
  curl -L https://github.com/peco/peco/releases/download/v0.4.9/peco_linux_amd64.tar.gz -o ~/tmp/peco.tar.gz
  tar zxvf ~/tmp/peco.tar.gz -C ~/tmp
  mv ~/tmp/peco_linux_amd64/peco ~/bin
  rm -rf ~/tmp/peco_linux_amd64/
  rm -rf ~/tmp/peco.tar.gz
fi

if ! type ghq >/dev/null 2>&1; then
  curl -L https://github.com/motemen/ghq/releases/download/v0.7.4/ghq_linux_amd64.zip -o ~/tmp/ghq.zip
  unzip ~/tmp/ghq.zip -d ~/tmp
  mv ~/tmp/ghq ~/bin
  rm -rf ~/tmp/ghq.zip
fi

if ! type direnv >/dev/null 2>&1; then
  curl -L https://github.com/direnv/direnv/releases/download/v2.12.2/direnv.linux-amd64 -o ~/bin/direnv
  chmod 0755 ~/bin/direnv
fi

if ! type gibo >/dev/null 2>&1; then
  curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -o ~/bin/gibo
  chmod 0755 ~/bin/gibo
  gibo -u
fi

#!/bin/bash
set -x

cd $(dirname $0)

if ! [ -e ${HOME}/bin ]; then
  mkdir ${HOME}/bin
fi

if ! [ -e ${HOME}/tmp ]; then
  mkdir ${HOME}/tmp
fi

if ! [ -e ${HOME}/mnt ]; then
  mkdir -p ${HOME}/mnt/sshfs
fi

if ! [ -e ${HOME}/.config/peco ]; then
  mkdir -p ${HOME}/.config/peco
fi

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
)

for file_name in "${file_names[@]}"; do
  ln -sf ${HOME}/.ghq/github.com/blp1526/dotfiles/${file_name} ~/
done

config_file_path=(
  peco/config.json
)

for config_file_path in "${config_file_path[@]}"; do
  ln -sf ${HOME}/.ghq/github.com/blp1526/dotfiles/.config/${config_file_path} ~/.config/${config_file_path}
done

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

. ~/.bash_profile >/dev/null 2>&1

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

if ! type gibo >/dev/null 2>&1; then
  curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo \
        -so ~/bin/gibo && chmod +x ~/bin/gibo && gibo -u
fi

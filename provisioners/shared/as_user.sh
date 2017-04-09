#!/bin/bash
set -x

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
  ln -sf ${HOME}/src/github.com/blp1526/dotfiles/${file_name} ~/
done

config_file_path=(
  peco/config.json
)

for config_file_path in "${config_file_path[@]}"; do
  ln -sf ${HOME}/.ghq/github.com/blp1526/dotfiles/.config/${config_file_path} ~/.config/${config_file_path}
done

if ! [ -e ~/.gitconfig.local ]; then
  echo 'Enter your user.name for .gitconfig'
  read name
  echo 'Enter your user.email for .gitconfig'
  read email

cat << __EOS__ > ~/.gitconfig.local
[user]
  name  = "${name}"
  email = "${email}"
__EOS__
fi

. ~/.bash_profile >/dev/null 2>&1

mkdir -p ~/.vim/pack/mypack/start

package_names=(
  kana/vim-tabpagecd
  ctrlpvim/ctrlp.vim
  tpope/vim-endwise
  scrooloose/syntastic
  rking/ag.vim
  plasticboy/vim-markdown
  simeji/winresizer
  MarcWeber/vim-addon-local-vimrc
  soramugi/auto-ctags.vim
  editorconfig/editorconfig-vim
  fatih/vim-go
)

for package_name in "${package_names[@]}"; do
  git clone --depth 1 https://github.com/${package_name}.git ${HOME}/.vim/pack/mypack/start/$(echo $package_name | awk -F / '{ print $2 }') >/dev/null 2>&1
done

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
fi

if ! type ghq >/dev/null 2>&1; then
  curl -L https://github.com/motemen/ghq/releases/download/v0.7.4/ghq_linux_amd64.zip -o ~/tmp/ghq.zip
  unzip ~/tmp/ghq.zip -d ~/tmp
mv ~/tmp/ghq ~/bin
fi

if ! type gibo >/dev/null 2>&1; then
  curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -o ~/bin/gibo
  chmod +x ~/bin/gibo
  gibo -u
fi

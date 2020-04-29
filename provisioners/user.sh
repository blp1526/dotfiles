#!/bin/bash

#####################
# GNOME Terminal Profile Preferences Colors Sample
#
# * Text and Background Color
#   * Built-in schemes: Tango dark
# * Palette
#   * Built-in schemes: Solarized
#####################

set -eux

mkdir -p ~/bin
mkdir -p ~/src

dotfiles_path=~/src/github.com/blp1526/dotfiles

ln -sf ${dotfiles_path}/bin/git-xclone ~/bin/git-xclone

mkdir -p ~/.config/nvim
ln -sf ${dotfiles_path}/.config/nvim/init.vim ~/.config/nvim/init.vim

mkdir -p ~/.config/peco
ln -sf ${dotfiles_path}/.config/peco/config.json ~/.config/peco/config.json

mkdir -p ~/.config/git
if ! [ -e ~/.config/git/ignore ]; then
  cp ${dotfiles_path}/.config/git/ignore ~/.config/git/ignore
fi

file_names=(
  .bashrc
  .gitconfig
  .vimrc
  .tmux.conf
  .tigrc
  .inputrc
  .lftprc
  .xsessionrc
)

for file_name in "${file_names[@]}"; do
  ln -sf "${dotfiles_path}/${file_name}" ~/"${file_name}"
done

if ! type anyenv >/dev/null 2>&1; then
  git clone https://github.com/anyenv/anyenv ~/.anyenv
  mkdir -p ~/.anyenv/plugins
  git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
fi

if ! type rustc >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh
fi

if ! type gibo >/dev/null 2>&1; then
  # https://github.com/simonwhitaker/gibo#installation
  git clone https://github.com/simonwhitaker/gibo.git ~/src/github.com/simonwhitaker/gibo
  ln -sf ~/src/github.com/simonwhitaker/gibo/gibo ~/bin/gibo
fi

if ! [ -e ~/src/github.com/Bash-it/bash-it ]; then
  git clone https://github.com/Bash-it/bash-it.git ~/src/github.com/Bash-it/bash-it
fi

if !  type diff-highlight >/dev/null 2>&1; then
  cp /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/bin/diff-highlight
  chmod 755 ~/bin/diff-highlight
fi

if ! type gh >/dev/null 2>&1; then
  tempdir=$(mktemp -d)
  cd "${tempdir}"
  version="$(curl https://api.github.com/repos/cli/cli/releases/latest | jq -r .tag_name | sed 's/v//g')"
  wget "https://github.com/cli/cli/releases/download/v${version}/gh_${version}_linux_amd64.tar.gz"
  tar zxvf "gh_${version}_linux_amd64.tar.gz"
  mv "gh_${version}_linux_amd64/bin/gh" ~/bin/gh
  rm -rf "${tempdir}"
fi

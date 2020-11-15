#!/usr/bin/env bash

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

if type sw_vers >/dev/null 2>&1 && ! type anyenv >/dev/null 2>&1; then
  git clone https://github.com/anyenv/anyenv ~/.anyenv
fi

if type anyenv >/dev/null 2>&1 && ! [ -e "$(anyenv root)/plugins/anyenv-update" ]; then
  mkdir -p "$(anyenv root)/plugins"
  git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"
fi

if type pyenv >/dev/null 2>&1 && ! [ -e "$(pyenv root)/plugins/pyenv-virtualenv" ]; then
  git clone https://github.com/pyenv/pyenv-virtualenv.git "$(pyenv root)/plugins/pyenv-virtualenv"
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

if ! type diff-highlight >/dev/null 2>&1; then
  if type sw_vers >/dev/null 2>&1; then
    cp /usr/local/share/git-core/contrib/diff-highlight/diff-highlight ~/bin/
  else
    # Ubuntu
    cp /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/bin/
  fi

  chmod 755 ~/bin/diff-highlight
fi

#!/usr/bin/env bash
set -ux -o pipefail

dotfiles_path="$(pwd)"

grep "source ${dotfiles_path}/.bashrc" ~/.bashrc
if [ "${?}" != "0" ]; then
  echo "source ${dotfiles_path}/.bashrc" >> ~/.bashrc
fi

mkdir -p ~/bin
ln -sf "${dotfiles_path}/bin/git-local-user" ~/bin/git-local-user

mkdir -p ~/.config/peco
ln -sf "${dotfiles_path}/.config/peco/config.json" ~/.config/peco/config.json

mkdir -p ~/.config/git
ln -sf "${dotfiles_path}/.config/git/ignore" ~/.config/git/ignore

mkdir -p ~/.config/nvim
ln -sf "${dotfiles_path}/.config/nvim/init.vim" ~/.config/nvim/init.vim

ln -sf "${dotfiles_path}/.gnupg/gpg-agent.conf" ~/.gnupg/gpg-agent.conf

file_names=(
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

if ! type diff-highlight; then
  if [ "$(uname)" == "Darwin" ]; then
    if type brew; then
      cp /usr/local/share/git-core/contrib/diff-highlight/diff-highlight ~/bin/
    fi
  else
    # Ubuntu
    cp /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/bin/
  fi
  chmod 755 ~/bin/diff-highlight
fi

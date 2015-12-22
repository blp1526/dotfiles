#!/bin/bash
set -x

if [ $(uname) = Darwin ]; then
  # Install manually below list not by homebrew cask
  # Google Chrome
  # Firefox
  # Google Japanese Input
  # iTerm2
  # VirtualBox
  # Vagrant
  # Alfred 2
  # Atom
  # Java
  # JMeter
  # OWASP ZAP
  # Dash
  # Evernote
  # Skitch
  # Karabiner
  # Shiftit
  # Slack
  # PopHub
  # The Unarchiver
  # WireShark
  # Kindle
  # Security Soft

  if ! type brew >/dev/null 2>&1; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew_names=(
    git
    hub
    gibo
    tig
    vim
    wget
    tree
    readline
    openssl
    nmap
    ctags
    bash-completion
    tmux
    mobile-shell
    direnv
    the_silver_searcher
    go
    rbenv
    ruby-build
    reattach-to-user-namespace
  )

  for brew_name in "${brew_names[@]}"; do
    brew install ${brew_name}
  done

  if type atom >/dev/null 2>&1; then
expected_apm_packages=$(cat << EOS
atom-beautify
atom-ctags
atom-fuzzy-grep
autoclose-html
autocomplete-paths
color-picker
ex-mode
file-icons
language-babel
linter
linter-jshint
linter-rubocop
minimap
minimap-autohide
project-manager
rails-open-rspec
railscast-theme
script
terminal-plus
vim-mode
vim-mode-visual-block
EOS
)
    current_apm_packages=$(apm list --installed --bare | awk -F @ '$NF != "" { print $1; }')
    apm_packages=$(
      diff -u <(echo "${current_apm_packages}") <(echo "${expected_apm_packages}") |
      awk '$1 != "+++" && $1 ~ /^\+/ { sub(/^\+{1}/, "", $1); print $1; }'
    )
    if [ "${apm_packages}" != "" ]; then
      for apm_package in "${apm_packages}"; do
        apm install ${apm_package}
      done
    fi
  fi

  if ! [ -e ${HOME}/bin ]; then
    mkdir ${HOME}/bin
  fi

  if ! type pecrant >/dev/null 2>&1; then
    curl -o ${HOME}/bin/pecrant https://raw.githubusercontent.com/gongo/pecrant/master/pecrant
    chmod +x ${HOME}/bin/pecrant
  fi
fi

cd $(dirname $0)

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
)

for file_name in "${file_names[@]}"; do
  ln -sf $(pwd)/${file_name} ~/
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
